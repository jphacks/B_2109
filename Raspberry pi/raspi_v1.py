import tkinter as tk
import threading
import serial
import time
import re
import datetime
from google.protobuf.timestamp_pb2 import Timestamp
import RPi.GPIO as GPIO
from PIL import Image, ImageTk 

class GUI(tk.Frame):
    def __init__(self,master = None):
        super().__init__(master)
        #初期変数
        h=768
        w=1024
        #canvas 初期化
        self.master = master
        master.geometry("1024x768")
        master.title("Test")
        self.canvas = tk.Canvas(master, bg='#FFF1B3', height=h, width=w)
        self.pack()

        #変数　栞関係　arduino用
        self.bk_ID=["bookmark_1","bookmark_2","bookmark_3","bookmark_4"]
        self.bk_open_now=[0,0,0,0]
        self.bk_open_old=[0,0,0,0]
        self.bk_mode_now=[0,0,0,0]
        self.bk_mode_old=[0,0,0,0]
        self.bk_max=[0,0,0,0]
        self.bk_num=4
        #変数　送信用
        self.read_start_data=[0,0]
        self.read_end_data=[0,0]
        self.read_start_mm=[0,0]
        self.read_end_mm=[0,0]
        #変数　状態遷移のフラグ
        self.switch_flag=0# 0=通常,1=初期登録
        self.switch_flag_old=0# 0=通常,1=初期登録
        self.mode_flag=0# 0=更新不要,1=サーバと通信
        self.bookmark_flag=0#変化した栞IDの保管
        self.view_flag=0# 各種フラグから最終的に表示する画面の指定
        self.view_flag_old=0# 各種フラグから最終的に表示する画面の指定
        self.flag=0
        #変数　内部用
        self.tag="normal"#現在表示中のタグを保存
        self.sp_time=0#現在表示中のタグを保存
        self.start_time=0#読書開始時間を保存
        self.end_time=0#読書終了時間を保存
        self.read=0
        self.goal=770#目標量を保存
        self.read_rate=0#進捗
        #self.set_posi=(850-110)*(self.per/self.goal)
        self.set_posi=110
        #表示画像
        
        self.switch_flag2=0
        self.switch_flag1=0
        self.count_1=0
        
        self.ut="sec"
        
        #PILでjpgを使用
        self.img1 = ImageTk.PhotoImage(file="tes.png")
        self.img3 = ImageTk.PhotoImage(file="bowl2.png")

        self.ser = serial.Serial('/dev/ttyACM0', 9600)
        
        self.count=0

        self.canvas.pack()

        self.timeEvent()# タイマー起動
        self.checkEvent()# タイマー起動



        #canvas.delete("oval")
    def create_normal(self):
        if(self.view_flag!=self.view_flag_old):
            self.canvas.create_image(0, 0, image=self.img1,anchor=tk.NW,tag="normal")
        if(self.flag==1):
            self.canvas.create_image(0, 0, image=self.img1,anchor=tk.NW,tag="normal")
            self.flag=0
        self.canvas.create_image(self.set_posi,400, image=self.img3,anchor=tk.NW,tag="normal2")
        self.canvas.create_text(self.set_posi,50,text=str(self.read)+"page",font=('',40), tag="normal2")
        self.canvas.create_text(self.set_posi,100,text=str(int(self.read_rate*100))+"%",font=('',40), tag="normal2")
        self.tag="normal"
        self.canvas.pack()

    def create_initial(self):
        if(self.view_flag!=self.view_flag_old):
            self.canvas.create_text(int(1024/2),int(768/6),text="初期登録",fill='#694E33',font=('',60), tag="initial")
            self.canvas.create_text(int(1024/3),int(768/6)*2,text="しおり①",fill='#694E33',font=('',40), tag="initial")
            self.canvas.create_text(int(1024/3),int(768/6)*3,text="しおり②",fill='#694E33',font=('',40), tag="initial")
            self.canvas.create_text(int(1024/3),int(768/6)*4,text="しおり③",fill='#694E33',font=('',40), tag="initial")
            self.canvas.create_text(int(1024/3),int(768/6)*5,text="しおり④",fill='#694E33',font=('',40), tag="initial")

        self.canvas.create_text(int(1024/3)*2,int(768/6)*2,text=self.bk_open_now[0],fill='#694E33',font=('',40), tag="initial2")
        self.canvas.create_text(int(1024/3)*2,int(768/6)*3,text=self.bk_open_now[1],fill='#694E33',font=('',40), tag="initial2")
        self.canvas.create_text(int(1024/3)*2,int(768/6)*4,text=self.bk_open_now[2],fill='#694E33',font=('',40), tag="initial2")
        self.canvas.create_text(int(1024/3)*2,int(768/6)*5,text=self.bk_open_now[3],fill='#694E33',font=('',40), tag="initial2")
        self.tag="initial"

        self.canvas.pack()
    def create_read_start(self):
        if(self.view_flag_old!=2):
            self.canvas.create_text(int(1024/2),int(768/3),text="読書中",fill='#694E33',font=('',60), tag="read")
        self.canvas.create_text(int(1024/2),int(768/3)*2,text=str(self.sp_time)+self.ut+"経過",fill='#694E33',font=('',60), tag="read2")
        self.tag="read"

        self.canvas.pack()
    def create_read_finish(self):
        self.canvas.create_text(int(1024/2),int(768/3),text="今回の読書時間:",fill='#694E33',font=('',60), tag="fin")
        if(int(self.end_time-self.start_time)>60):
            self.canvas.create_text(int(1024/2),int(768/3)*2,text=str(int((self.end_time-self.start_time)/60))+self.ut,fill='#694E33',font=('',60), tag="fin")
        else:
            self.canvas.create_text(int(1024/2),int(768/3)*2,text=str(int(self.end_time-self.start_time))+self.ut,fill='#694E33',font=('',60), tag="fin")
            
        self.tag="fin"

        self.canvas.pack()


        
    # タイマー起動用関数
    def timeEvent(self):
        th1 = threading.Thread(target=self.update)# スレッドインスタンス生成
        th1.start()# スレッドスタート
        self.after(1000, self.timeEvent)# ここで、再帰的に関数を呼び出す

    def checkEvent(self):#arduinoからの通信を監視、フラグの管理
        th2 = threading.Thread(target=self.check_flag)# スレッドインスタンス生成
        th2.start()# スレッドスタート
        self.after(500, self.checkEvent)# 
        
    def check_server_Event(self):#arduinoからの通信を監視、フラグの管理
        th3 = threading.Thread(target=self.get_server_data)# スレッドインスタンス生成
        th3.start()# スレッドスタート
        self.after(1000, self.checkEvent)# ここで、再帰的に関数を呼び出す
    
    def check_flag(self):
        ##
        ##arudino
        #raw_data="4,S,1,1,10,2,1,20,3,1,30,4,1,40,\r\n,5,3"
        #time.sleep(0.5)
        raw_data=self.ser.read_all()
        #print(raw_data)
        #print(type(raw_data))
        raw_data=raw_data.decode()
        data=raw_data.split(",")
        if("S" in data):
            if(len(data[data.index("S"):])>=((self.bk_num*3)+1)):
                data = data[data.index("S"):]
        #print(data)
        #print(len(data))
        #print(data)
        #if(self.switch_flag1==0):
        #    data[2]="0"
        #if(self.switch_flag2==0):
        #    data[2]=1
        #print(data)
        
        if(data[0]=="S"):
            print(data)
            for i in range(self.bk_num):
                self.bk_mode_now[i]=data[(i*3)+2]
                self.bk_open_now[i]=data[(i*3)+3]
                
                
                #print("test1")
            self.bk_open_now[3]=re.sub(r'[^0-9]',"",str(self.bk_open_now[3]))
            print(self.bk_open_now[3])
            for i in range(1):
                if(self.bk_mode_now[i]!=self.bk_mode_old[i]):
                    print("test2")
                    print(self.bk_mode_now[i])
                    if(self.bk_mode_now[i]==str(0)):#読書開始
                        print("test3")
                        self.bookmark_flag=i
                        self.read_start_data[i]=datetime.datetime.now()
                        self.start_time=time.time()
                        self.read_start_mm[i]=self.bk_open_old[i]
                        self.view_flag=2
                    elif(self.bk_mode_now[i]==str(1)):#読書終了
                        print("test4")
                        self.read_end_data[i]=datetime.datetime.now()
                        self.end_time=time.time()
                        self.read_end_mm[i]=self.bk_open_now[i]
                        self.read=self.read_end_mm[i]
                        self.mode_flag=1# 0=更新不要,1=サーバと通信
                        self.view_flag=3
            for i in range(self.bk_num):
                self.bk_mode_old[i]=self.bk_mode_now[i]
                self.bk_open_old[i]=self.bk_open_now[i]
        else:
            pass
    # スレッド処理実体
    def update(self):

        now=time.time()
        int()
        self.sp_time=int(now-self.start_time)
        if(self.sp_time>60):
            self.ut="分"
            self.sp_time=int(self.sp_time/60)
        else:
            self.ut="秒"
        #self.canvas.delete()
        #print(self.count) # デバッグメッセージ 

        self.get_server_data()
        self.ras_sw()
        if(self.switch_flag==1):
            self.view_flag=1
        if(self.switch_flag_old==1 and self.switch_flag==0):
            self.view_flag=0
            
        if(self.view_flag!=self.view_flag_old):
            self.canvas.delete(self.tag)
            
        if(self.view_flag==0):#通常画面
            self.canvas.delete("initial")
            self.canvas.delete("initial2")
            self.canvas.delete("read")
            self.canvas.delete("read2")
            self.canvas.delete("fin")
            self.create_normal()
        elif(self.view_flag==1):#本の初期登録画面　
            self.canvas.delete("initial2")
            self.canvas.delete("normal")
            self.canvas.delete("normal2")
            self.canvas.delete("read")
            self.canvas.delete("read2")
            self.canvas.delete("fin")
            self.create_initial()
        elif(self.view_flag==2):#読書中
            self.canvas.delete("normal")
            self.canvas.delete("normal2")
            self.canvas.delete("initial")
            self.canvas.delete("initial2")
            self.canvas.delete("read2")
            self.canvas.delete("fin")
            self.create_read_start()
        elif(self.view_flag==3):#
            if(self.count_1==0):
                self.canvas.delete("normal")
                self.canvas.delete("normal2")
                self.canvas.delete("initial")
                self.canvas.delete("initial2")
                self.canvas.delete("read")
                self.canvas.delete("read2")
                self.canvas.delete("fin")
                self.create_read_finish()
                self.connection()
                self.read_rate=int(self.read)/int(self.goal)
                self.set_posi=int(850*(self.read_rate))
                print(self.read)
            self.count_1=self.count_1+1
            if(self.count_1>5):
                self.count_1=0
                print("test")
                self.flag=1
                self.view_flag=0
        print(self.view_flag)
        self.view_flag_old=self.view_flag
        self.count=self.count+1
        self.switch_flag_old=self.switch_flag

    def get_server_data(self):
        print("get server")
        self.goal=770#目標量を保存

    def connection(self):#サーバと通信
        pass

    def ras_sw(self):#物理スイッチ確認
        pin1 = 23 #39=GND
        pin2 = 22 #39=GND
        pin3 = 24 #39=GND
        GPIO.setmode(GPIO.BCM)
        GPIO.setup(pin1, GPIO.IN, pull_up_down = GPIO.PUD_DOWN)
        GPIO.setup(pin2, GPIO.IN, pull_up_down = GPIO.PUD_DOWN)
        GPIO.setup(pin3, GPIO.IN, pull_up_down = GPIO.PUD_DOWN)

        sw = GPIO.input(pin1)
        sw2 = GPIO.input(pin2)
        sw3 = GPIO.input(pin3)
        if sw == False:
            self.switch_flag=0
        else:
            self.switch_flag=1
        
        if sw2 == False:
            self.switch_flag1=0
        else:
            self.switch_flag1=1
            
        if sw3 == False:
            self.switch_flag2=0
        else:
            self.switch_flag2=1
        GPIO.cleanup()


if __name__ == "__main__":

    gui = tk.Tk()
    gui.attributes('-fullscreen', True)
    app = GUI(master = gui)
    app.mainloop()




#実装内容
#状態遷移図作成
#それに応じたメソッド作成
#機能
#arduinoから状態を受け取る
#初期登録スイッチの状態を確認する
#サーバにポストする
#画面を作る
#
#
#