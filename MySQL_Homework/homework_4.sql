use db02;
select *from food;
select *from place;

--- 1.	查詢所有比'鳳梨酥'貴的食物名稱、日期日和價格
SELECT name, expiredate, price FROM food 
WHERE price > (SELECT price FROM food WHERE name = '鳳梨酥');

--- 2.	查詢所有比'曲奇餅乾'便宜且種類是'點心'的食物名稱、日期日和價格
SELECT name, expiredate, price FROM food 
WHERE price < (SELECT price FROM food WHERE name = '曲奇餅乾')AND catalog = '點心';

--- 3.	查詢所有和'鳳梨酥'同一年到期的食物名稱、日期日和價格
SELECT name, expiredate, price FROM food 
WHERE YEAR(expiredate) = (SELECT YEAR(expiredate) FROM food WHERE name = '鳳梨酥');

--- 4.	查詢所有比平均價格高的食物名稱、日期日和價格
SELECT name, expiredate, price FROM food 
WHERE price > (SELECT avg(price) FROM food);

--- 5.	查詢所有比平均價格低的'台灣'食物名稱、日期日和價格
SELECT f.name, f.expiredate, f.price FROM food f JOIN place p ON f.placeid = p.id 
WHERE f.price < (SELECT avg(price) FROM food) AND p.name = '台灣';

--- 6.	查詢所有種類和'仙貝'相同且價格比'仙貝'便宜的食物名稱、日期日和價格
SELECT name, expiredate, price, catalog FROM food 
WHERE price < (SELECT price FROM food WHERE name = '仙貝') 
AND catalog = (SELECT catalog FROM food WHERE name = '仙貝');

--- 7.	查詢所有產地和'仙貝'相同且到期日超過6個月以上的食物名稱、日期日和價格
SELECT name, expiredate, price, catalog FROM food 
WHERE placeid = (SELECT placeid FROM food WHERE name = '仙貝') 
AND expiredate > adddate(sysdate(),interval 6 month);

--- 8.	查詢每個產地價格最低的食物名稱、日期日和價格
SELECT f.name, f.expiredate, f.price, p.name FROM food f JOIN place p ON f.placeid = p.id   
WHERE f.price <= ALL(SELECT price FROM food WHERE placeid = f.placeid );

--- 9.	查詢每個種類的食物價格最高者的食物名稱和價格
SELECT f.name, f.price, catalog FROM food f   
WHERE f.price >= ALL(SELECT price FROM food WHERE catalog = f.catalog );

--- 10.	查詢所有種類不是'點心'但比種類是'點心'貴的食物名稱、種類和價格，並以價格做降冪排序
SELECT f.name, f.price, catalog FROM food f   
WHERE f.price > ALL(SELECT price FROM food WHERE catalog = '點心' ) AND catalog <> '點心'
order by price DESC;

--- 11.	查詢每個產地(顯示產地名稱)的食物價格最高者的食物名稱和價格
SELECT f.name, f.price, p.name FROM food f JOIN place p ON f.placeid = p.id 
WHERE f.price >= ALL (SELECT price FROM food WHERE placeid = f.placeid);
