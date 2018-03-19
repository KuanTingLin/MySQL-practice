use db02;
select *from food;
select *from place;
SET SQL_SAFE_UPDATES=0;

--- 1.	以不列舉欄位的方式新增一筆食物資料
INSERT INTO food
VALUES ('CK006','溏心蛋','2017-11-15 00:00:00','TW',45,'點心' );

--- 2.	以列舉欄位的方式新增一筆食物資料
INSERT INTO food (id,name,expiredate,placeid,price,catalog)
VALUES ('CK007','沖繩黑糖','2019-12-15 00:00:00','jp',200,'點心' );
 -- 失誤QQ
UPDATE food
SET placeid = 'JP'
WHERE id = 'CK007';

--- 3.	以不列舉欄位的方式新增多產地資料
INSERT INTO place (id,name)
VALUES ('UK','英國'),('HK','香港');

--- 4.	修改一筆食物資料的價格
UPDATE food
SET price = 250
WHERE id = 'CK007';
--- 5.	按價格分250以下、251~500和501以上三種分別增加8%,5%和3%且價格無條件捨去成整數
UPDATE food f
SET price =  CASE 
when price < 251 THEN (price *1.08)div 1
when price between 251 and 500 THEN (price *1.05 )div 1
else (price *1.03 )div 1
END ;

--- 6.	刪除一筆食物資料
delete FROM food WHERE id = 'CKOO7';