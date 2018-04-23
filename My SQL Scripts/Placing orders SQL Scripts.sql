use classicmodels;
/*Write a stored procedure that implements a shopping cart
Product Co*/

create table CART (
	customerNumber int not null,
    productCode varchar(15) not null,
    quantity tinyint not null default 1,
    constraint cart_cust_fk foreign key(customerNumber)
		references customers(customerNumber),
	constraint cart_pro_fk foreign key(productCode)
		references products(productCode),
	constraint cart_pk primary key(customerNumber,productCode)
);

/*Add item to Cart*/
drop procedure if exists AddItemtoCart;
delimiter  //
create procedure AddItemToCart(custNumber int, prodCode varchar (15))
    begin
        declare quant smallint;
       select quantity into quant from cart
            where customerNumber=custNumber
           and productCode=prodCode;
        if quant is null then
            insert into cart values (custNumber, prodCode,1); 
       else
            update cart set quantity=quantity+1
                where (customerNumber=customerNumber and productCode=productCode);
        end if;
    end//
delimiter ;


-- orderDetails table will be affected: order#,prodCode, quantity, priceEach,orderLine#
-- order table has order#, OrderDate, requiredDate (does not take NULL),shippeddate,status,comments,customerNumber
select distinct orderlinenumber from orderdetails;

drop procedure if exists PlaceOrder;
delimiter  //
create procedure Placeorder(custNumber int)
begin
    declare lineItem, finished int default 0;
   declare ordNumber int;
   declare ProdCode varchar(15);
   declare quant smallint;
   declare cart_cursor cursor for
        select productCode, quantity from cart where
            customerNumber=custNumber;
   declare continue handler for not found set finished=1;  
   DECLARE EXIT HANDLER FOR SQLEXCEPTION
   BEGIN
        ROLLBACK;
       SELECT 'An error has occurred, operation rollbacked and the stored procedure was terminated';
    END;
       
       start transaction;
       select max(orderNumber)+1 into ordNumber from orders;
       insert into orders values (ordNumber, CURDATE(),
            date_add(curdate(),interval 3 day), null, 'In Process',null, custNumber);    
open cart_cursor;
    cart_loop: LOOP
        fetch cart_cursor into ProdCode, quant;
        if finished=1 then
            leave cart_loop;
        end if;
        insert into orderdetails values (ordNumber, ProdCode, quant, 
            (select MSRP from product where productCode=ProdCode), lineItem);
    end loop cart_loop;
close cart_cursor;
if lineItem=0 then
    rollback;
   select 'Cart is empty.'
endif;
commit;
	select concat('order placed',lineItem, 'item(s)');
end//
delimiter ;
/*-------------------------------*/
drop function if exists OrgchartLevel;
delimiter //
create function OrgchartLevel(empId int)
	returns int
    not deterministic
begin
	declare supID int;
    declare lvl int default 0;
    loop
		select reportsTo into supId from employees where employeeNumber=empId;
        if supId is null then return lvl;
        end if;
        set lvl = lvl + 1;
        set empId = supId;
	end loop;
end //
delimiter ;
