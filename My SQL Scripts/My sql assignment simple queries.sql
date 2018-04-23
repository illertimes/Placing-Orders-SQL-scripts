
/* Write a query to display the name, product line, and buy price of all products.
 The output columns should display as “Name”, “Product Line”, and “Buy Price”. The output should display the most expensive items first.*/
use classicmodels;
Select productName NAME, productLine as 'Product Line' , buyPrice as 'Buy Price'
from products
order by buyPrice desc;
/*Write a query to display each of the unique values of the status field in the orders table. 
The output should be sorted alphabetically increasing. Hint: the output should show exactly 6 rows.*/
select distinct status 
from orders
order by status asc;

/* Write a query to display the first name, last name, and city for all customers from Germany. 
Columns should display as “First Name”, “Last Name”, and “City”. The output should be sorted by the customer’s last name (ascending). */
Select contactLastName, contactFirstName, city
from customers
where country= 'Germany'
order by contactLastName asc;


/*Select all fields from the payments table for payments made on or after January 1, 2005. Output should be sorted by increasing payment date.*/
Select paymentDate, amount, customerNumber, checkNumber
from payments
order by paymentDate > 2005-01-01 asc;

/* Write a query to display all Last Name, First Name, Email and Job Title of all employees working out of the San Francisco office.
 Output should be sorted by last name.*/
select e.lastName as 'Last Name', e.firstName as 'FirstName', e.email Email, e.jobTitle as 'Job Title'
from employees e join offices o on e.officeCode=o.officeCode
where o.city='San Francisco'
order by e.lastName; 

/*Write a query to display the Name, Product Line, Scale, and Vendor of all of the car products –
 both classical and vintage. The output should display all vintage cars first (sorted alphabetically by name), and all classical cars last (also sorted alphabetically by name). */
select productName NAME, productline 'Product Line', productScale Scale, productVendor Vendor
from products
where productLine in ('Classic Cars', 'Vintage Cars')
order by productLine desc, productName asc; 