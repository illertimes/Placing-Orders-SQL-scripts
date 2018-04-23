
use classicmodels;
Delimiter //
Create procedure GetAllProducts()
	begin
    select* from products;
    end //
delimiter ;
call GetAllProducts();

/* a variable that begins with an accent*/
Declare total_count int default 0;

Set @total_count =10;
/*Test loop */
DELIMITER $$
 DROP PROCEDURE IF EXISTS mysql_test_repeat_loop$$
 CREATE PROCEDURE mysql_test_repeat_loop()
 BEGIN
 DECLARE x INT;
 DECLARE str VARCHAR(255);
        
 SET x = 1;
        SET str =  '';
        
 REPEAT
 SET  str = CONCAT(str,x,',');
 SET  x = x + 1; 
        UNTIL x  > 5
        END REPEAT;
 
        SELECT str;
 END$$
 DELIMITER ;
 
 
/*Write a stored procedure that implements a shopping cart
Product Co*/

create table CART (
	item_code varchar()not null,quanity smallint() not null, customerNumber int()not null,references customer()customerNumber, 
    primary key(product_code,customerNumber)
);