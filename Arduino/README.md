# しおりのArduinoプログラム
Arduinoはしおり型計測器のセンサを読み取り，表示機にデータを送信する役割を担っています．
その動作コードが Arduino.ino となります．
以降は動作コードの各機能を説明します．
## 読書状態の読み取り機能
しおり型計測器は下記の3つのセンサが取り付けられています．
 - 可変抵抗器
 - ホールIC
 - 圧力センサ
これらセンサの電圧変化をArduinoのアナログ入力ピンで読み取っています．
これらセンサの入力を総合して読書状態の判定を行っています．

## Raspberry Piとの通信プログラム
### 読書状態の送信機能
読書状態をRaspberry Piにシリアル通信で送信する機能です．
読書状態には2通りあります．
 - モード0：しおりは止まり木を挟んでいて，ユーザや読書中
 - モード1：しおりは本を挟んでいて，ユーザは読書を終えている

Arduinoはモード0からモード1に切り替わるタイミングで，可変抵抗器の電圧値からページ数を0〜約1000の値で出力します．

送信形式について説明します．
1つ目のしおりIDをID[1]，モードをMODE[1]，厚さをVALUE[1]と表記すると，読書状態は下記形式のストリングで送信されます．
```
",S,ID[1],MODE[1],VALUE[1],ID[2],MODE[2],VALUE[2],...,\l\n"
```

### 読書経過割合の受信機能
しおりには本を読まずに放置すればするほどフクロウが怒って，翼を上げて目を光らせる機能があります．
そのために，Raspberry Piから最後に読書を経過してからどれだけ経過したのかを受信します．
この数値は積ん読経過割合と呼び，{(現在時刻 - 最後の読書時刻) / とある期間 * 100}で計算されます．

通信形式としては，1つ目のしおりに挟まれた読書経過割合をRATE[1]と表記すると，下記形式のストリングでやり取りします．
```
"S,RATE[1],RATE[2],...,\n"
```

## 読書経過割合に応じたフクロウの動作
前項で述べたように，フクロウには読書経過割合に応じて，フクロウの目のLEDが光り，サーボでによって動く羽が回転します．
サーボは読書経過割合に比例して0〜150度まで回転します．
フクロウの目のLEDの明るさは，読書経過割合が50%以下ではOFFとなります．
読書経過割合が50%〜100%まで変化すると，それに比例して明るさが0%〜100%まで変化します．
