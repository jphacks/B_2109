//接続ピンの指定
const int VOLUME_PIN = A0;  //可変抵抗器の信号線をA0に接続
const int MAGNET_PIN = A1;  //ホールICの信号線をA1に接続
const int PRESSURE_PIN = A2;  //圧力センサの信号線をA2に接続

//時間関連の定数と変数
const int LOOP_TIME = 50;  //ループの間隔[msec]
const int SEND_DURATION = 500; //通信間隔[msec]
const int DETECT_DELAY = 1000;  //厚み計測の遅延時間[msec]

//センサ初期値の指定
const int INITIAL_VOLUME = 0;  //可変抵抗器の角度0度のときの値


//センサデータの格納変数定義
int VOLUME; //可変抵抗器（厚み）の値
int MAGNET; //ホールIC（止まり木）の値
int PRESSURE; //圧力センサの値
double SEND_VOLUME; //RasPiに送信する用の可変抵抗の値
int BOOK_WIDTH;  //可変抵抗の値を厚みに変換した値

//条件の事前判定用のbool変数
bool ON_BRANCH; //止まり木にいるときにTrueになる
bool ON_HAND; //ユーザが洗濯ばさみを挟んでいるか否かの判定

//モード関連の変数定義
int MODE = 3; //Arduino内のモード判定（初期値は読書中）
int PRE_MODE; //一個前のモード
int SEND_MODE; //RasPiに送信するようのモード

//時間関連のカウント変数
int COUNT;  //厚み計測に必要な遅延のカウントを格納する
int SEND_COUNT;  //通信間隔を制御するカウントを格納する

//文字列操作用の変数
char string[50]; //sprintfのフォーマット用の文字列

//現在のページ数算出 関連
const float ALL_PAGES = 458; //
const float ALL_BOOK_WIDTH = 510;
int NUM_PAGES; //現在のページ数

void setup() {
  Serial.begin( 9600 );     // シリアル通信を初期化する。通信速度は9600bps
}

void loop() {
  //アナログ値の読み取り
  VOLUME = analogRead(VOLUME_PIN);  //可変抵抗器の値を読み取り
  VOLUME = VOLUME - INITIAL_VOLUME;  //ゼロ点の分だけ抵抗値をオフセット
  MAGNET = analogRead(MAGNET_PIN);  //ホール素子（止まり木判定）の値を読み取り
  PRESSURE = analogRead(PRESSURE_PIN);  //圧力センサ（つかみ判定）の値を読み取り

  //止まり木と把持判定を事前にしておく
  ON_BRANCH = MAGNET > 600 || MAGNET < 415; //止まり木に止まったらTrue
  ON_HAND = PRESSURE < 1000; //しおりを掴んだらTrue

  //現在のモードの判定
  switch (PRE_MODE) {
    case 0: //前モードが保持中のとき
      if (ON_HAND) {
        MODE = 0; //しおりを持っていたら保持中モードを維持
      } else if (ON_BRANCH) {
        MODE = 1; //止まり木に止まっていたら読書中モードへ
      } else if (! ON_BRANCH) {
        MODE = 2; //止まり木にとまってなかったら値読み取りモードへ
      }
      break;
      
    case 1: //前モードが読書中
      if (ON_HAND) {
        MODE = 0; //しおりを掴んでたら保持中モードへ移行
      } else {
        MODE = 1; //しおりを掴んでなかったら読書中モードを維持
      }
      break;
      
    case 2: //前モードが値読み取り
      if (COUNT >= DETECT_DELAY) {
        MODE = 3; //0.7秒以上経過したら収納中モードへ移行
        SEND_VOLUME = VOLUME; //値読み取り→収納中に移行した時のみ，RasPiに送信する可変抵抗値を更新
      } else if (ON_HAND) {
        MODE = 0; //圧力センサがONになったら保持中へ移行
      } else {
        MODE = 2; //なにもなければ値読み取りモードを維持
      }
      break;

    case 3:
      if (ON_HAND) {
        MODE = 0; //しおりが掴まれたら保持中へ移行
      } else {
        MODE = 3; //しおりが掴まれなかったら収納中を維持
      }
      break;
  }

  //MODEに応じた処理
  switch (MODE) {
    case 0:
      COUNT = 0;  //値読み取りカウントクリア
      break;
    case 1:
      SEND_MODE = 0; //RasPiにはモード0を送る
      break;
    case 2:
      COUNT += LOOP_TIME; //値読み取りのカウントをすすめる
      break;
    case 3:
      COUNT = 0; //値読み取りカウントクリア
      SEND_MODE = 1; //RasPiにはモード1を送る
      break;
  }

  //PRE_MODEの更新
  PRE_MODE = MODE;

  //RaspberryPiとの通信
  if (SEND_COUNT >= SEND_DURATION) {
    //角度→厚さ変換とページ数計算をする
    BOOK_WIDTH =  int(SEND_VOLUME * SEND_VOLUME * (-0.0003)  +  1.7043 * SEND_VOLUME + 13.014);  //角度→厚さ変換
    if (BOOK_WIDTH < 0) {
      BOOK_WIDTH = 0;  //厚みが負にならないようにする
    }
    NUM_PAGES = int(float(BOOK_WIDTH) / ALL_BOOK_WIDTH * ALL_PAGES);  //PAGE数の計算

    // 本の厚さを送信したい場合はtrueに，本のページ数を送信したい場合はfalseにしてください．
    if (true) {
      sprintf(string, "S,1,%d,%d,2,1,195,3,1,85,4,1,315",SEND_MODE,BOOK_WIDTH);  //文字列に変数を埋め込む
    } else {
      sprintf(string, "S,1,%d,%d,2,1,70,3,1,70,4,1,70",SEND_MODE,NUM_PAGES);  //文字列に変数を埋め込む
    }
    
    Serial.println(string); //文字列をRasPaiにシリアル通信で送信
    SEND_COUNT = LOOP_TIME;  //カウント初期化
  } else {
    SEND_COUNT += LOOP_TIME;  //カウントをすすめる．
  }
  
  delay(LOOP_TIME);  //ループ間隔LOOP_TIME[msec]だけ待つ
}
