




# SQL 無論是query language還是db_name, column_name等都不區分大小寫
# 千萬不要忘記句末的;
# cmd+shifit+enter 來執行execute all
# cmd+enter來執行此行execute current line
# name非保留字，會變色但不用緊張
#MySQL規定函式預設的寫法是函式名稱和左括號之間不可以有任何空格，否則會造成錯誤；你可以執行「SET sql_mode=’IGNORE_SPACE’」，這個設定讓你可以在函式名稱和左括號之間加入空格也不會出錯。



#-----------------------------------------------------------------基本 SELECT 操作--------------------------------------------------------------------------#

#SHOW DATABASES;
show databases;

#USE db_name;
use world;

###### SELECT statement 查詢敘述 ######
#用法一：單用select子句，查詢運算式結果（只是簡單的顯示字串和計算結果，並不會查詢資料庫中的資料）
SELECT 'My name is Simon Johnson', 35 * 12;
#用法二：使用select子句搭配FROM子句，查詢某table的特定columns
select * from city;
select * from world.city;
select countrycode from city;
select countrycode from world.city;
##SELECT子句加入運算子
#數學運算子：+, - , *, /, div(整除), mod或%(餘數), 
use cmdev;
select * from emp;
select empno, ename, salary, salary div 12 from emp;  #等於select empno, ename, salary, (salary div 12) from emp; 有時加上括號會更清楚有幾個欄位

##用[AS]取欄位別名: 讓執行查詢後的結果，使用你自己取的名稱為欄位名稱
#註1：如果是運算式的話，通常就要幫它取一個欄位別名來取代原來一大串的運算式。
#註2 : 如果欄位別名是保留字或包含空格者，需使用單引號括起來
use cmdev;
select * from emp;
select salary div 12 as 'monthly salary' from emp; 

#使用DISTINCT回傳不重複的資料
select DISTINCT ename from cmdev.emp; 

###### 使用WHERE子句進行條件篩選 ######
# 比較運算子：=, <=>(mysql特有的運算子，可以判斷null的等於), !=或<>(不等於), <, <=, >, >=
# 邏輯運算子：NOT(非, 通常配合IS或IN使用), &&(而且), AND(而且), ||(或), OR(或), XOR(互斥)
#                       注意！and 的優先序高於or, 因此必要時請使用括號
# 其他條件運算子：BETWEEN … AND …：範圍比較, IN (…)：成員比較, IS：是…, IS NOT：不是…, LIKE：像…
# 字串樣式：LIKE '...', 配合 %(代表0到多個任何字元), _ (代表一個任何字元)

select * from world.city where countrycode = 'TWN' and population >= 1000000 ; #字串必須擁單引號括起來
select * from cmdev.emp where hiredate < '1981-09-08'; #日期也需要單引號
select name, continent, population from world.country where (continent = 'Europe' or 'Africa' ) and population<10000;
select * from cmdev.emp where hiredate between '1981-09-08' and '1990-09-08';
select * from world.city where countrycode in ('TWN', 'USA', 'JPN', 'KOR');

select name, lifeexpectancy from world.country where lifeexpectancy is null;
select name, lifeexpectancy from world.country where lifeexpectancy <=> null;
select name, lifeexpectancy from world.country where lifeexpectancy is not null;

select name from world.city where name like '__________w%';

###### ORDER BY 子句對查徐結果排序 ######
select * from world.city where population > 100 order by countrycode;      #預設用升冪排列
select * from world.city where population > 100 order by countrycode;      #降冪排列
select * from world.city where population > 100 order by countrycode, name;  #可以設定巢狀的(多個)排序條件
select empno, ename, salary from cmdev.emp order by salary div 2;        #排序條件亦可為運算式或是alias或是欄位編號

###### LIMIT 子句限制結果只回傳前N筆 ######
#除非再測試而已，必須配合在ORDER BY 後面分析才會比較有意義
select * from world.city where population > 100 order by countrycode limit 3; 
select * from world.city where population > 100 order by countrycode limit 10, 3; #代表跳過前十筆，回傳第11-13筆資料～～


#--------------------------------------------------------------------- MySQL 資料類型-------------------------------------------------------------------------------#
###### 根據資料類型可以分為下列幾種：###### 
# 數值：可以用來執行算數運算的數值，包含整數與小數，分為精確值與近似值兩種
# 字串：使用單引號包圍的文字
# 日期/時間：使用單引號包圍的日期或時間
# 空值：使用「NULL」表示的值
# 布林值：「TRUE」或「1」表示「真」，「FALSE」或「0」表示「假」

##數值：
#數值可分為(1)精確值(2)近似值
#(1)精確值可分為
#                         (1-1)整數：沒有小數的數字，範圍從-9223372036854775808到9223372036854775807
#                         (1-2)小數：包含小數的數字，整數範圍與上面一樣，小數位數最多可以有30個
#(2)近似值的的數字通常稱為「科學表示法」，它使用「XE+Y」格式來表示：
#「XE+Y」格式中的「+」可以省略，例如「5E+3」與「5E3」是一樣的。
# 例如5E+3或5E3，代表的數字為5000
# 例如5E-3，代表的數字為0.005
# 注意：使用比較運算子比較近似值是危險的！！運算時可能進位，例如0.1E0+0.2E0 = 0.3E0回傳的是False喔!!

##字串：
# 使用CONCAT()進行串接


## 日期/時間：
#日期與時間有下列幾種：
# date：年年年年-月月-日日，’2007-01-01′
# datetime：年年年年-月月-日日 時時:分分:秒秒，’2007-01-01 12:00:00′
# time：時時:分分:秒秒：’12:00:00′
# 註1: 日期值中預設的分隔字元是「-」，你也可以使用「/」，所以「2000-1-1」與「2000/1/1」都是正確的日期值。
# 註2: 西元年的部份，可以使用四個或兩個數字。如果指定的兩個數字是「70」到「99」之間，就代表「1970」到「1999」；如果是「00」到「69」之間，就代表「2000」到「2069」。

# 日期時間資料可以使用於(1)條件判斷外 (2)配合+- INTERVAL 數字 時間單位(year, quarter, month, day, hour, minute, second) 進行運算
# 為了達成(2)的效果，亦可使用ADDDATE(日期, 天數), ADDTIME(日期時間, interval 數字 時間單位 )
select * from cmdev.emp where hiredate < '1982-09-08' - interval 1 year;
select * from cmdev.emp where hiredate < CURDATE() - interval 10 year;


## 「NULL」
# null最特別的地方是「NULL值與其它任何值都不一樣，包含NULL自己」
# 如果算數運算式或比較運算式中有任何「NULL」值的話，結果都會是「NULL」!!!
select null = null, null < null, null !=null, null +3; # 結果皆為null
select null is null, null <=> null, isnull(null);                           #唯二能對null進行比較運算的運算子與ISNULL()函式，可搭配not等邏輯運算子來使用




#--------------------------------------------------------------------- MySQL 常用函式-------------------------------------------------------------------------------#
## 註：MySQL規定函式預設的寫法是函式名稱和左括號之間不可以有任何空格，否則會造成錯誤；你可以執行「SET sql_mode=’IGNORE_SPACE’」，這個設定讓你可以在函式名稱和左括號之間加入空格也不會出錯。
## 所有函式請參考，MySQL官方手冊中的「Chapter 12. Functions and Operators」alter


## 數值處理相關函式：
# 數值捨去與進位的函式：-----------------------------------------------------
#ROUND(數字)：四捨五入到整數
#ROUND(數字, 位數)：四捨五入到指定的位數
#CEIL(數字)、CEILING(數字)：進位到整數
#FLOOR(數字)：捨去所有小數
#TRUNCATE(數字, 位數)：將指定的[數字]捨去指定的[位數]

# 算數運算的函式：---------------------------------------------------------------
#PI()：圓周率
#POW(數字1, 數字2)、POWER(數字, 數字2)：[數字1]的[數字2]次方
#RAND()：亂數
#SQRT(數字)：[數字]的平方根
#註1：RAND() 會傳回一個>=0而且<=1的小數數字。如果你的敘述中需要一個固定範圍內的亂數，可以搭配RAND()*x+y之類的運算產生
select rand()+1;
#註2：RAND() 搭配ORDER BY可以完成「隨機查詢」的需求
select * from cmdev.emp order by rand() limit 3;

## 字串函式:
# 字串內容的相關函式：----------------------------------------------------------
#LOWER(字串)：將[字串]轉換為小寫
#UPPER(字串)：將[字串]轉換為大寫
#LPAD(字串1, 長度, 字串2)：如果[字串1]的長度小於指定的[長度]，就在[字串1]左邊使用[字串2]補滿      (對齊用)
#RPAD(字串1, 長度, 字串2)：如果[字串1]的長度小於指定的[長度]，就在[字串1]右邊使用[字串2]補滿   （對齊用）
#LTRIM(字串)：移除[字串]左邊的空白
#RTRIM(字串)：移除[字串]右邊的空白
#TRIM(字串)：移除[字串]左、右的空白
#REPEAT(字串, 個數)：重複[字串]指定的[個數]
#REPLACE(字串1, 字串2, 字串3)：將[字串1]中的[字串2]替換為[字串3]

# 截取字串內容的函式：----------------------------------------------------------
#LEFT(字串, 長度)：傳回[字串]左邊指定[長度]的內容
#RIGHT(字串, 長度)：傳回[字串]右邊指定[長度]的內容
#SUBSTRING(字串, 位置)：傳回[字串]中從指定的[位置]開始到結尾的內容
#SUBSTRING(字串, 位置, 長度)：傳回[字串]中從指定的[位置]開始，到指定[長度]的內容

# 連接字串的函式：-----------------------------------------------------------------
#CONCAT(參數 [,…])：傳回所有參數連接起來的字串
#CONCAT_WS(分隔字串, 參數 [,…])：傳回所有參數連接起來的字串，參數之間插入指定的[分隔字串]
#註：「CONCAT」與「CONCAT_WS」兩個函式的參數可以接受任何型態的資料，它們都會把全部的資料轉為字串後連接起來；「CONCAT」函式的參數中如果有「NULL」值，結果會是「NULL」；「CONCAT_WS」函式的參數中如果有「NULL」值，「NULL」值會被忽略。

# 取得字串資訊的函式：-----------------------------------------------------------
#LENGTH(字串)：傳回[字串]的長度(bytes)
#CHAR_LENGTH(字串)：傳回[字串]的長度(字元個數)
#LOCATE(字串1, 字串2)：傳回[字串1]在[字串2]中的位置，如果[字串2]中沒有[字串1]指定的內容就傳回0

## 日期時間函式:
#取得日期與時間的函式：-----------------------------------------------------------
#CURDATE()：取得目前日期，相同功能：CURRENT_DATE、CURRENT_DATE()
#CURTIME()：取得目前時間，相同功能：CURRENT_TIME、CURRENT_TIME()
#YEAR(日期)：傳回[日期]的年，相似的有MONTH(日期) , DAY(日期)=DAYOFMONTH(日期), HOUR(時間)：傳回[時間]的時, MINUTE(時間)：傳回[時間]的分, SECOND(時間)：傳回[時間]的秒
#註：使用「EXTRACT()」函式用來取得日期時間資料的指定「單位」，例如日期中的月份，可以取代YEAR(), MONTH(), DAY()等這類函式：
#MONTHNAME(日期)：傳回[日期]的月份名稱，相似的有DAYNAME(日期)：傳回[日期]的星期名稱
#DAYOFWEEK(日期)：傳回[日期]的星期，1到7的數字，表示星期日、一、二…，相似的有DAYOFYEAR(日期)：傳回[日期]的日數，1到366的數字，表示一年中的第幾天, QUARTER(日期)：傳回[日期]的季，1到4的數字，代表春、夏、秋、冬
#EXTRACT(單位 FROM 日期/時間)：傳回[日期]中指定的[單位]資料
#註：最常用「CURDATE()」與「CURTIME()」，可以取得目前伺服器的日期與時間

# 計算日期與時間的函式：-----------------------------------------------------------
#ADDDATE(日期, 天數)：傳回[日期]在指定[天數] 以後的日期
#ADDDATE(日期, INTERVAL 數字 單位)：傳回[日期]在指定[數字]的[單位]以後的日期
#ADDTIME(日期時間, INTERVAL數字 單位)：傳回[日期時間]在指定[數字]的[單位]以後的日期時間
#SUBDATE(日期, 天數)：傳回[日期]在指定[天數] 以前的日期
#SUBDATE(日期, INTERVAL 數字 單位)：傳回[日期]在指定[數字]的[單位]以前的日期
#SUBTIME(日期時間, INTERVAL數字 單位)：傳回[日期時間]在指定[數字]的[單位]以前的日期時間
#DATEDIFF(日期1, 日期2)：計算兩個日期差異的天數
#註：最常用「ADDDATE()」,「ADDTIME()」,「DATEDIFF()」


#--------------------------------------------------------------------- MySQL 流程控制-------------------------------------------------------------------------------#

##如果要完成條件判斷，可以使用IF()函式搭配select
select ename, hiredate, IF(year(hiredate)<1985, 'Senior', 'General') as grade from cmdev.emp order by hiredate;
select ename, hiredate, salary * IF(year(hiredate)<1985, 16, 14) bonus from cmdev.emp order by hiredate;
##(很重要)對null的值進行判斷與處理，IFNULL()搭配select
select ename, salary, comm, salary + ifnull(comm, 0) FullSalary from cmdev.emp;

##如果要完成多種條件的判斷，就要使用下列的「CASE」語法搭配select
select ename, salary,
CASE
	WHEN salary >= 3000 THEN 'A'
	WHEN salary >= 1000 AND salary <= 2999 THEN 'B'
	ELSE 'C'
END SalaryGrade
from cmdev.emp order by salary desc;

select name, continent,
CASE continent
	WHEN 'Asia' THEN 'AS'
	WHEN 'Europe' THEN 'EU'
	WHEN 'Africa' THEN 'AF'
END ContinentCode
From world.country;


#--------------------------------------------------------------------- 基本統計分析查詢、群組函數-------------------------------------------------------------------------------#
## 群組函式:
# 處理量化資料(數值、時間日期)：-----------------------------------------------------------
#MAX(運算式)：最大值
#MIN(運算式)：最小值
#SUM(運算式)：合計
#AVG(運算式)：平均
#COUNT([DISTINCT]*|運算式)：使用「DISTINCT」時，重複的資料不會計算；使用[*]時，計算表格紀錄的數量：使用[運算式]時，計算的數量不會包含「NULL」值

select sum(population) PopSum, avg(population) PopAvg, max(population) PopMin, Min(population) PopMin, COUNT(*) Amount from world.country;
select count(*), count(code), count(IndepYear), count(distinct IndepYear) from world.country;
#亦即，count(*)平常是計算有幾筆record，無論使否為null; 而指定欄位則會排除null的欄位alter

# 處理字串資料：
#使用「GROUP_CONCAT」函式的話，只會回傳一筆紀錄，這筆紀錄包含所有字串資料串接起來的內容：
select GROUP_CONCAT(distinct dname order by dname) from cmdev.dept;

## GROUP BY與HAVING 對群組進行統計
# 針對select中某個欄位做group by
#在上列使用群組函式的所有範例中，都是將「FROM」子句中指定的表格當成是一整個「群組」，群組函式所處理的資料是表格中所有的紀錄。如果希望依照指定的資料來計算分組統計與分析資訊，在執行查詢：
select region, sum(population) from country GROUP BY region HAVING sum(population) > 100000000;
#註：having的條件限制為“群組”的特性限制，通常搭配群組函式做計算
select region, sum(population) from country where name like'A%' GROUP BY region HAVING sum(population) > 1000000;
select region, name, sum(population) from country where name like'A%' GROUP BY region, name;

#冠廷想知道這兩個效能誰比較好？
select region, sum(population) from country where region like'S%' GROUP BY region HAVING sum(population) > 1000000;
select region, sum(population) from country GROUP BY region HAVING sum(population) > 1000000 and region like'S%' ;


#WITH ROLLUP會在最後面做個*的小結
select continent, sum(population) from country group by continent WITH ROLLUP;
select continent, max(population) from country group by continent WITH ROLLUP;
select continent, region, max(population) from country group by continent WITH ROLLUP;
#MySQL資料庫在執行上列的查詢敘述後，並不會產生任何錯誤，為了預防這樣的狀況，你可以執行下列的設定：
SET sql_mode = 'ONLY_FULL_GROUP_BY';
#這樣就會限定所有出現在select查詢結果的欄位，都需要被當作group by的依據
select continent, region, sum(population) from country group by continent, region WITH ROLLUP;


#--------------------------------------------------------------------- 跨表格查詢JOIN, 縱向合併UNION------------------------------------------------------------------#
#在「world」資料庫中有兩張表格world.country和world.capital。雖然「country」表格只有儲存城市的ID，不過它可以使用country表格中「Capital」欄位的值，對照到「city」表格中的「ID」欄位的值，就可以知道城市的名稱。
#在這樣的表格設計架構下，如果你想要查詢「所有國家的首都名稱」，這樣的查詢需求就稱為「結合查詢JOIN」，也就是你要查詢的資料，來自於一個以上的表格，而且兩個表格之間具有上列討論的「對照」情形。

##Inner Join:
#「Inner join」可以應付大部份的結合查詢需求。
# 內部結合有兩種寫法，差異在把結合條件設定在「WHERE」子句或「FROM」子句中。
#寫法一：將結合條件寫在where子句中（較不推薦）
select country.code, country.capital, city.name 
from country, city
where country.capital = city.id;
# 註1：若兩個表格中，欄位名稱沒有相同的情況，可以省略[table_name.]column_name
select code, capital, city.name 
from country, city
where country.capital = city.id;
# 註2：表格名稱通常比較長，可以利用FROM子句 幫每個表格名稱分別取一個字母的別名
select a.code, a.capital, b.name 
from country a, city b
where a.capital = b.id;

#寫法二：使用INNER JOIN 搭配ON或USING(只能接同名的欄位)-------------------->推薦！！
Select code, capital, city.name 
from country INNER JOIN city ON country.capital = city.id;

Select code, capital, city.name 
from country INNER JOIN city ON capital = id;

Select empno, ename, dname
from cmdev.emp e, cmdev.dept d
where e.dptno = d.deptno;

Select empno, ename, dname
from cmdev.emp e INNER JOIN cmdev.dept d
ON e.deptno = d.deptno;

Select empno, ename, dname
from cmdev.emp e INNER JOIN cmdev.dept d
USING (deptno);

##Outer Join:
#在「cmdev」的員工資料(emp)表格中，部門編號(deptno)欄位是用來儲存員工所屬的部門用的；不過有一些員工並沒有部門編號，此時使用「內部結合」的作法執行下列的查詢，你會發現少了兩個員工的資料．這是因為使用「內部結合」的查詢，一定要符合「結合條件」的資料才會出現
#因此在希望所有的資料都出現在合併的大表中時，outer join就派上用場了

#LEFT OUTER JOIN，代表以左邊的表格為主
#RIGHT OUTER JOIN，代表以右邊的表格為主

#其實使用「LEFT OUTER JOIN」或是「RIGHT OUTER JOIN」並沒有差異
#以上列的需求來說，要查詢「包含部門名稱的員工資料，沒有分派部門的員工也要出現」，就是要以「cmdev.emp」表格的資料為主，所以下列兩種寫法所得到的結果是完全一樣的
select empno, ename, deptno, dname
from cmdev.emp e LEFT OUTER JOIN cmdev.dept d
USING (deptno);

select empno, ename, deptno, dname
from cmdev.dept d RIGHT  OUTER JOIN cmdev.emp e
USING (deptno);

# 縱向合併表格UNION(不那麼實用)
#「合併、UNION」查詢，指的是把一個以上的查詢敘述所得到的結果合併為一個，有這樣的需求時，你會在多個查詢敘述之間使用「UNION」關鍵字：
# 使用UNION時，這些查詢的欄位數量必須一致，且欄位名稱使用第一個查詢的欄位名稱
Select region, name, population from country where region = 'Southeast Asia' OR 'Eastern Asia'
UNION
Select ename, job, salary from cmdev.emp where salary <1000;

#--------------------------------------------------------------------- CRUD------------------------------------------------------------------#

## 新增INSERT INTO, REPLACE
#法一：按照table之欄位順序
INSERT INTO cmdev.dept VALUES (70, 'MARKETING', DEFAULT);
#法二：自行指定欄位順序與數量
INSERT INTO cmdev.dept (dname, deptno) VALUES  ('R&D', 80);
#法三：如果有null值時，法二須改寫為
INSERT INTO cmdev.dept SET deptno=90, dname='HR', location = null;
#批次新增
INSERT INTO cmdev.dept VALUES 
(100, 'A', DEFAULT),
(110, 'B', DEFAULT),
(120, 'C', DEFAULT);
#使用replace代替insert在重複輸入時會直接修改原有紀錄，而不會報錯

##修改UPDATE
#基本的修改指令
UPDATE cmdev.emp SET salary = salary+100;
# 在安全模式下，都要加上一個where條件
# 否則會出現Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a Primary KEY column To disable safe mode, 設定變數SET SQL_SAFE_UPDATES=0;
UPDATE cmdev.emp SET salary = salary+100 where empno=7369;
# 在SET SQL_SAFE_UPDATES=0的情況下，你可以使用where salary>10000或 order by salary DESC limit 3等條件進行批次修改

##刪除DELETE
DELETE from cmdev.emp where deptno=60;
# 在安全模式下，都要加上一個where條件
# 否則會出現Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a Primary KEY column To disable safe mode, 設定變數SET SQL_SAFE_UPDATES=0;
DELETE from cmdev.emp where empno=7369;
# 要刪除一個表格中所有紀錄，使用truncate(慎用！！！！)
#TRUNCATE [TABLE] cmdev.emp;

#--------------------------------------------------------------------- 子查詢 ------------------------------------------------------------------#



#待整理 子查詢, index設定
#待學習：Prepared Statement, Stored Routines
#Reference:
#http://www.codedata.com.tw/database/mysql-tutorial-getting-started/

