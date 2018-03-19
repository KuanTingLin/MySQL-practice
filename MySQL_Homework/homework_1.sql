--- 1.	建立一資料表名為食物(food)，有編號、名稱、到期日、產地編號、價格、種類六個欄位，分別定義如下：
--- id(char(5),PK), name(varchar(30)), expiredate(datetime), placeid(char(2)), price(int unsigned), catalog(varchar(20))

use db02;
create table tasted(
id			char(5)			primary key,
food		varchar(15)  	not null,
deadline	datetime		not null,
price		int	unsigned	not null,
love		varchar(10)		not null,
catalog		varchar(20)		not null
);

--- 2.	建立一資料表名為產地(place)，有編號、名稱兩個欄位，分別定義如下：id(char(2),PK), name(varchar(20))

create table catalog(
id			char(5)			primary key,
food		varchar(15)		not null
);

select *from tasted;
alter table catalog
add catalog varchar(20);
select *from catalog;


--- 3.	利用複製表格結構的方式複製food產生一個新的表格名為food1

create table food1 like tasted;

--- 4.	利用food1新增、修改、重新命名和刪除一個欄位

alter table food1
add kiss int;

select *from food1;

alter table food1
change kiss lovely double;

alter table food1
modify food char after catalog;

alter table food1
drop lovely;

--- 5.	將food1重新命名為food2

alter table food1
rename food2;

--- 6.	刪除food2資料表

drop table food2;

 -- select distinct love , catalog from tasted;