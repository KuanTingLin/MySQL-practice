## MySQL 安裝筆記：
Windows安裝請繞道
http://www.codedata.com.tw/database/mysql-tutorial-database-abc-mysql-installation/

## Mac/Linux 安裝 MySQL 以及 mysql workbench 如下：
<br>1.參考官方文件，下載MySQL Server: https://dev.mysql.com/doc/refman/5.6/en/osx-installation-pkg.html ＊安裝完會自動幫你設定是root user跟配一組臨時密碼給你，找地方存起來 （超重要！！！）
<br><br>2.從terminal去到MySQL安裝的folder (e.g. /usr/local/mysql-5.7.21-macos10.13-x86_64，我們要將這個資料夾設為$MYSQL_HOME
<br><br>i. vim ~/.bashrc (如果你跟我一樣使用zshshell，請輸入vim ~/.zshrc）
<br><br>ii. 拉到最底下進行編輯(按i)，加入以下三行
<br><br>iii. ## MYSQL
<br><br>iv. MYSQL_HOME=/usr/local/mysql-5.7.21-macos10.13-x86_64
<br><br>v. export PATH=$MYSQL_HOME/bin:$PATH
<br><br>vi.存檔離開(先按esc鍵再按:wq)
<br><br>3. 啟動MySQL的方式有兩種選擇:
<br><br>a. 選擇一：使用terminal
<br><br>i. % cd /Library/LaunchDaemons                                                   
<br><br>ii. sudo launchctl load -F com.oracle.oss.mysql.mysqld.plist
<br><br>iii.接下來在Password:後面輸入電腦的使用者密碼
<br><br>b. 選擇二：使用MAC的system preferences GUI
<br><br>i. system preferences-> MySQL -> Start MySQL Server 把database server啟動
<br><br>4. 回到terminal，輸入 mysql -u root -p 
<br><br>5. 一樣會出現Password:，這次請輸入剛剛存下的MySQL root user臨時密碼
<br><br>a. 在 mysql> 輸入 ALTER USER ‘root’@’localhost’ IDENTIFIED BY ‘新密碼’;  （這應該會重設密碼）＊注意，複製貼上可能出現錯誤，單引號（'）請自己用手重打～
<br><br>6.完成囉！在mysql>  後面可以打任何sql指令對MySQL進行CRUD(增刪改查)


## 如果你想要更漂亮的GUI介面，可以下載mysql workbench (https://dev.mysql.com/downloads/workbench/）
<br>1. 將MySQLWorkbench的圖是按照箭頭方向拖曳至Applications
<br><br>2. 安裝好之後將MySQLWorkbench安裝檔退出
<br><br>3. 到Applications單擊MySQLWorkbench，將它置於dock中
<br><br>4. 雙擊單擊MySQLWorkbench，GUI就打開囉！
<br><br>5. 進入MySQLWorkbench的第一件事，就是在mysql workbench加入一個新的connection (按照我workbench screenshot那樣，密碼打入你剛剛重置的新密碼）然後應該就會連線上去，那邊你的query就可以寫在裡面執行。＊localhost:3306，代表mysql裝在你本地電腦，開放連接的port號是預設的3306

## References:
https://megansunblog.wordpress.com/2017/06/02/mysql安裝-mac安裝mysql資料庫的方法/
https://www.digitalocean.com/community/tutorials/a-basic-mysql-tutorial
