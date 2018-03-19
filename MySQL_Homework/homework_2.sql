use db02;

create table food(
id			char(5)			primary key, 
name		varchar(30)		not null, 
expiredate	datetime		not null, 
placeid		char(2)			not null, 
price		int unsigned	not null, 
catalog		varchar(20)		not null
);
create table place(
id			char(5)			primary key, 
name		varchar(30)		not null
);

--- 1.	查詢所有食物表格中所有欄位的資料
select *from food;

--- 2.	查詢所有食物名稱、到期日和價格
select name,expiredate,price  from food;

--- 3.	查詢所有食物名稱、到期日和價格，並將表頭重新命為'名稱'、'到期日'和'價格'
select name '名稱',expiredate '到期日',price '價格'  from food;

--- 4.	查詢所有食物的種類有哪些？(重覆的資料只顯示一次)
select distinct catalog from food;

--- 5.	查詢所有食物名稱和種類，並串接成一個字串，中間以空白隔開，並將表頭重新命為'Food name & catalog'
select name||' 是 '||catalog 'Food name & catalog' from food; 

-- WHERE子句
--- 6.	查詢所有食物價格超過400的食物名稱和價格
select name,price from food where price >= 400;

--- 7.	查詢所有食物價格介於250~530之間的食物名稱和價格
select name,price from food where price >= 250 and price <= 530;
select name,price from food where price between 250 and 530;

--- 8.	查詢所有食物價格不介於250~530之間的食物名稱和價格
select name,price from food where price not between 250 and 530;

--- 9.	查詢所有食物種類為'點心'的食物名稱和價格
select name,price from food where catalog = '點心';

--- 10.	查詢所有食物種類為'點心'和'飲料'的食物名稱、價格和種類
select name,price,catalog from food where catalog = '點心' or catalog = '飲料';

--- 11.	查詢所有食物產地為'TW'和'JP'的食物名稱和價格
select name,price from food where placeid = 'TW' or placeid = 'JP';

--- 12.	查詢所有食物名稱有'油'字的食物名稱、到期日和價格
select name,expiredate,price from food where name like '%油%';

--- 13.	查詢所有食物到期日在今年底以前到期的食物名稱和價格
select name,price from food where year(expiredate)<2018;

--- 14.	查詢所有食物到期日在明年6月底以前到期的食物名稱和價格
select name,expiredate,price from food where expiredate < '2018/07/01 00:00:00';

--- 15.	查詢所有食物6個月內到期的食物名稱和價格
select name '食物',price '價錢', expiredate '到期日', curdate() '今天日期' from food where expiredate < adddate(curdate(),interval 6 month );

--- ORDER BY子句

--- 16.	查詢所有食物名稱、到期日和價格，並以價格做降冪排序
select name '食物', expiredate '到期日', price'價格' from  food order by price DESC;

--- 17.	查詢前三個價格最高的食物名稱、到期日和價格，並以價格做降冪排序
select name '食物', expiredate '到期日', price'價格' from food order by price DESC limit 3;

--- 18.	查詢種類為'點心'且價格低於等於250的食物名稱和價格，並以價格做升冪排序
select name '食物', price'價格', catalog '種類' from food where '點心' = catalog and price <= 250 order by price DESC;

--- 19.	顯示所有食物名稱、價格和增加5%且四捨五入為整數後的價格，新價格並將表頭命名為'New Price'
select name '食物', price'價格', round(price *105 / 100 ,0) 'New Price' from food ;

--- 20.	接續上題，再增加一個表頭命名為'Increase'，顯示New price減去price的值
select name '食物', price'價格', round(price *1.05 ,0) 'New Price', round(price *1.05 ,0) - price 'Increase' from food ; -- 不簡潔


--- 21.	顯示所有食物名稱、價格和整數後的價格，新價格並將表頭命名為'New Price'；按價格分250以下、251~500和501以上三種分別增加8%,5%和3%且價格無條件捨去成整數
select name '食物', price '價格', case
when price < 251 THEN (price *1.08)div 1
when price between 251 and 500 THEN (price *1.05 )div 1
else (price *1.03 )div 1
end 'New Price'
from food;

--- 22.	查詢所有食物名稱、種類、距離今天尚有幾天到期(正數表示)或已過期幾天(負數表示)和註記(有'已過期'或'未過期'兩種)，並將後兩者表頭分別命名為'Days of expired'和'expired or not'
select name '食物', catalog '種類', datediff(expiredate,sysdate()) 'Days of expired', if(datediff(expiredate,sysdate())< 0,'已過期','未過期') 'expired or not', expiredate '到期日', sysdate() from food;

--- 23.	接續上題，並以過期天數做升冪排序
select name '食物', catalog '種類', datediff(expiredate,sysdate()) 'Days of expired', if(datediff(expiredate,sysdate())< 0,'已過期','未過期') 'expired or not', expiredate '到期日', sysdate() from food order by datediff(expiredate,sysdate()) ASC;

--- GROUP BY & HAVING子句
--- 24.	查詢所有食物最高、最低、加總和平均價格，表頭分別命名為'Max'、'Min'、'Sum'和'Avg'，結果皆以四捨五入的整數來顯示
select round(max(price)) 'Max', round(min(price)) 'Min', round(sum(price)) 'Sum', round(avg(price)) 'Avg' from food;

--- 25.	接續上題，查詢每個種類
select catalog,round(max(price)) 'Max', round(min(price)) 'Min', round(sum(price)) 'Sum', round(avg(price)) 'Avg' from food group by catalog;

--- 26.	接續上題，查詢每個種類且平均價格超過300，並以平均價格做降冪排序
select catalog,round(max(price)) 'Max', round(min(price)) 'Min', round(sum(price)) 'Sum', round(avg(price)) 'Avg' from food group by catalog having round(avg(price)) > 300 order by round(avg(price)) DESC;

--- 27.	顯示查詢每個種類的食物數量
select catalog, count(name) from food group by catalog;

--- 28.	查詢不同產地和每個種類的食物數量
select placeid, catalog, count(name) from food group by placeid, catalog;
