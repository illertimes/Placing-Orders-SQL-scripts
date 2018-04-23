use classicmodels;

show tables;
describe orderdetails;
/* Write a query to list each customer lastname and the # of orders they placed*/

Select c.contactFirstName, c.contactLastName, count(o.orderNumber) Orders
from orders o right join customers c on o.customerNumber= c.customerNumber
group by c.contactFirstName, c.contactLastName
order by Orders;

/*Refine the above query to show only customers who have place between 5 and 10 orders(inclusive)*/
Select c.contactFirstName, c.contactLastName, count(o.orderNumber) Orders
from orders o right join customers c on o.customerNumber= c.customerNumber
group by c.contactFirstName, c.contactLastName 
having orders between 5 and 10;

/* Write a query listing the customerName and the total (sum) of the customer's payments. Include in the sum only payments made after Jan.1,2004. do not include cistomers who have made no payments in that time.*/
Select c.customerName, sum(p.amount) 
from customers c join payments p using(customerNumber)
where paymentDate >= '2004-01-01'
group by c.customerName;

Select * from orders;
Select* from orderdetails;
select* from customers;
Select* from productlines;

/*Write a query to list customerName of all customers who have ever ordered an item 
from an item from either the motorcycles or Trains product lines*/
Select distinct c.customerName
from customers c join orders o using (customerNumber)
join orderdetails od using(orderNumber)
join products p using(productCode)
where p.productline in ('Motorcycle', 'Trains');

/*Write a query that lists each product line and total #items in that product line sold. 
Include only orders with a status of 'shipped'.*/
Select products.productline, sum(od.quantityOrdered)
from products join orderDetails od using(productCode)
join orders o using(orderNumber)
where o.status='Shipped'
group by products.productline;

show tables;
describe orderdetails;
describe employees;
describe customers;
describe orders;
/*Write a query to list each employee's last name, first name, and the sum total revenue 
(buyPrice * itemsOrdered) of the order's they've generated.*/
Select employees.lastName, employees.firstName, sum(orderdetails.quantityordered*orderdetails.priceEach) revenue
from customers join employees on  employees.employeenumber=customers.salesrepemployeenumber 
join orders  using (customernumber)
join orderdetails using (ordernumber)
group by employees.lastName, employees.firstName;
/*Modify the above query to list just those employees who generated revenue greater than average 
per employee revenue
Step 1: Write a query to calculate the Revenue of the original query. put in a subquery
Step 2: Use #1 in a having clause.*/
(select avg(SumTotalRevenue) From (select employees.lastName, employees.firstName
/*Write a query to categorize customers by their order volumes. Output the name of each customer and either "high", 
"Medium", or "Low":
"High" means they have placed 7 or more orders.
"Medium" means they have placed between 3 and 6 orders
"Low" means they have placed 2 or less orders */
select customers.customerName,
	case
		when count(orders.orderNumber)>= 7 then 'High'
        when count(orders.orderNumber) between 3 and 6 then 'Medium'
        else 'Low'
	end as Volume 
    from customers c join orders o using(customerNumber)
    group by customers.customerName
    order by Volume desc;