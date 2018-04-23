show databases;

use learningsql;

show tables;


Select p.name, pt.name
from product p join product_type pt
on p.PRODUCT_TYPE_CD = pt.PRODUCT_TYPE_CD;

show tables;

select b.name , b.city, e.LAST_NAME, e.title
from branch b join employee e
on b.branch_id=e.ASSIGNED_BRANCH_ID;
/*show a list of each unique employee title 
*/
select distinct title from employee;
/*Show the last name and title of each employee, along with the last name and title of that employee's boss */
select e.last_name, e.title, eb.last_name, eb.title
from employee e left join employee eb
on e.SUPERIOR_EMP_ID =eb.EMP_ID;

show tables;
/*for each account, show the name of the 
account's product, the availiable balance, and customer's last name*/
select  p.name,a.avail_balance, i.last_name
from account a join product p 
on a.product_cd= p.product_cd
join individual i on a.cust_id=i.cust_id;


