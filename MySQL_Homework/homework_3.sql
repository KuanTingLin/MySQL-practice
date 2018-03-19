use db02;
select *from food;
select *from place;
--- 1.	查詢所有食物名稱、產地編號、產地名稱和價格
select f.name '食物名稱', f.placeid '產地編號', p.name '產地名稱',f.price'價格' from food f join place p on f.placeid = p.id;
select f.name '食物名稱', f.placeid '產地編號', p.name '產地名稱',f.price'價格' from food f, place p where f.placeid = p.id;

--- 2.	查詢所有食物名稱和產地名稱，並串接成一個字串，中間以空白隔開，並將表頭重新命為'Food name & place';
select concat(f.name,' ',p.name) 'food name & place' from food f join place p on f.placeid = p.id;
select concat(f.name,' ',p.name) 'food name & place' from food f , place p where f.placeid = p.id;

--- 3.	查詢所有'台灣'生產的食物名稱和價格
select f.name '食物名稱',f.price'價格' from food f join place p on f.placeid = p.id  where p.name = '台灣';
select f.name '食物名稱',f.price'價格' from food f , place p where f.placeid = p.id and p.name = '台灣';

--- 4.	查詢所有'台灣'和'日本'生產的食物名稱和價格，並以價格做降冪排序
select p.name '產地名稱',f.name '食物名稱',f.price'價格' from food f join place p on f.placeid = p.id  where p.name = '台灣' or p.name = '日本' order by f.price DESC;
select p.name '產地名稱',f.name '食物名稱',f.price'價格' from food f , place p where f.placeid = p.id and (p.name = '台灣' or p.name = '日本') order by f.price DESC;

--- 5.	查詢前三個價格最高且'台灣'生產的食物名稱、到期日和價格，並以價格做降冪排序
select f.name '食物名稱',f.expiredate '到期日' ,f.price'價格' from food f join place p on f.placeid = p.id  where p.name = '台灣' order by f.price DESC limit 3;
select f.name '食物名稱',f.expiredate '到期日' ,f.price'價格' from food f , place p where f.placeid = p.id  and p.name = '台灣' order by f.price DESC limit 3;

--- 6.	查詢每個產地(顯示產地名稱)最高、最低、加總和平均價格，表頭分別命名為'Max'、'Min'、'Sum'和'Avg'，結果皆以四捨五入的整數來顯示
select p.name'產地',round(max(f.price)) 'Max', round(min(f.price)) 'Min', round(sum(f.price)) 'Sum', round(avg(f.price)) 'Avg' from food f join place p on f.placeid = p.id group by p.name;
select p.name'產地',round(max(f.price)) 'Max', round(min(f.price)) 'Min', round(sum(f.price)) 'Sum', round(avg(f.price)) 'Avg' from food f , place p where f.placeid = p.id group by p.name;

--- 7.	查詢不同產地(顯示產地名稱)和每個種類的食物數量
select p.name '產地', f.catalog '種類', count(f.name) '數量' from food f join place p on f.placeid = p.id group by p.name,f.catalog;
select p.name '產地', f.catalog '種類', count(f.name) '數量' from food f , place p where f.placeid = p.id group by p.name,f.catalog;

--- 8.	查詢每個產地(顯示產地名稱)的食物價格最高者的食物名稱和價格
select f.name '食物', f.price '價格' , p.name'產地' from food f, place p WHERE f.placeid = p.id 
group by f.placeid,f.price HAVING f.price = (SELECT MAX(price) FROM food WHERE placeid = f.placeid);
-- 子查詢裡面想要用到外面的欄位資料，外面就必須有使用到 having 要用到 group by 就要有用到才能
select f.name '食物', f.price '價格' , p.name'產地' from food f join place p on f.placeid = p.id 
group by p.id,f.price HAVING f.price = (SELECT MAX(price) FROM food WHERE placeid = p.id);

SELECT f.name, f.price, p.name 
FROM food f JOIN place p ON f.placeid = p.id 
WHERE (f.placeid,f.price) 
IN (SELECT placeid,MAX(price) FROM food GROUP BY placeid);
