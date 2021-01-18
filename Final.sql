-- down thuang12
if exists (select * from INFORMATION_SCHEMA.CONSTRAINT_TABLE_USAGE
    where CONSTRAINT_NAME = 'fk1_order_id')
    alter table TWfood_order_meals drop fk1_order_id
if exists (select * from INFORMATION_SCHEMA.CONSTRAINT_TABLE_USAGE
    where CONSTRAINT_NAME = 'fk2_meal_id')
    alter table TWfood_order_meals drop fk2_meal_id
go
if exists (select * from INFORMATION_SCHEMA.CONSTRAINT_TABLE_USAGE
    where CONSTRAINT_NAME = 'fk_employee_store_id')
    alter table TWfood_employees drop fk_employee_store_id
go
if exists (select * from INFORMATION_SCHEMA.CONSTRAINT_TABLE_USAGE
    where CONSTRAINT_NAME = 'fk1_order_customer_id')
    alter table TWfood_orders drop fk1_order_customer_id
if exists (select * from INFORMATION_SCHEMA.CONSTRAINT_TABLE_USAGE
    where CONSTRAINT_NAME = 'fk2_order_store_id')
    alter table TWfood_orders drop fk2_order_store_id
go
if exists (select * from INFORMATION_SCHEMA.CONSTRAINT_TABLE_USAGE
    where CONSTRAINT_NAME = 'fk1_rating_customer_id')
    ALTER TABLE TWfood_ratings drop fk1_rating_customer_id
if exists (select * from INFORMATION_SCHEMA.CONSTRAINT_TABLE_USAGE
    where CONSTRAINT_NAME = 'fk2_rating_order_id')
    ALTER TABLE TWfood_ratings drop fk2_rating_order_id
go
drop table if exists TWfood_meals
go
drop table if exists TWfood_order_meals
go
drop table if exists TWfood_employees
go
drop table if exists TWfood_ratings
go
drop table if exists TWfood_orders
go
drop table if exists TWfood_stores
go
drop table if exists TWfood_customers
go
-- up thuang12
create table TWfood_customers(
    customer_id int IDENTITY not null,
    customer_firstname varchar(30) not null,
    customer_lastname varchar(30) not null,
    customer_phone varchar(10) not null,
    customer_email varchar(30) not null,
    CONSTRAINT pk_TWfood_customers PRIMARY key(customer_id),
    constraint u1_TWfood_customer_phone UNIQUE(customer_phone),
    constraint u2_TWfood_customer_email UNIQUE(customer_email)
)
GO
create table TWfood_stores(
    store_id int IDENTITY not null,
    store_name varchar(30) not null,
    store_phone varchar(10) not null,
    store_street varchar (50) not null,
    store_city varchar(25) not null,
    store_state varchar(2) not null,
    constraint pk_TWfood_stores PRIMARY key(store_id),
    constraint u1_TWfood_store_name UNIQUE (store_name),
    constraint u2_TWfood_store_phone UNIQUE (store_phone),
    constraint u3_TWfood_store_phone UNIQUE (store_street)
)
GO
CREATE TABLE TWfood_orders(
    order_id int identity not null,
    order_time DATETIME not null,
    pickup_time DATETIME not null,
    order_status varchar(20) not null,
    order_customer_id int not null,
    order_store_id int not null,
    constraint pk_TWfood_orders PRIMARY KEY (order_id)
)
go
create table TWfood_ratings(
    rating_id int IDENTITY not null,
    service_rating int null,
    meal_rating int null,
    rating_customer_id int not null,
    rating_order_id int not null,
    constraint pk_TWfood_rating PRIMARY key (rating_id),
    constraint ck_service_rating check (service_rating between 1 and 5),
    constraint ck_meal_rating check(meal_rating between 1 and 5)
)
GO
create table TWfood_employees(
    employee_id int IDENTITY not null,
    employee_firstname varchar(30) not null,
    employee_lastname varchar(30) not null,
    employee_ssn varchar(9) not null,
    employee_jobtype varchar(10) not null,
    employee_payrate float not null,
    employee_title varchar(10) null,
    employee_store_id int not null,
    constraint pk_TWfood_employees PRIMARY KEY (employee_id),
    constraint u_TWfood_employees UNIQUE (employee_ssn)
)
go 
create table TWfood_order_meals(
    order_id int not null,
    meal_id int not null,
    CONSTRAINT pk_TWfood_order_meals PRIMARY key(order_id, meal_id)
)
GO
create table TWfood_meals(
    meal_id int IDENTITY not null,
    meal_name varchar(50) not null,
    meal_price FLOAT not null,
    constraint pk_TWfood_meals PRIMARY KEY(meal_id)
)
-- add FK thuang12
go
alter table TWfood_ratings ADD
    constraint fk1_rating_customer_id FOREIGN key (rating_customer_id) REFERENCES TWfood_customers(customer_id),
    CONSTRAINT fk2_rating_order_id FOREIGN KEY (rating_order_id) REFERENCES TWfood_orders(order_id)
GO
alter table TWfood_orders ADD
    constraint fk1_order_customer_id FOREIGN KEY (order_customer_id) REFERENCES TWfood_customers(customer_id),
    constraint fk2_order_store_id FOREIGN KEY (order_store_id) REFERENCES TWfood_stores(store_id)
GO
alter table TWfood_employees ADD
    CONSTRAINT fk_employee_store_id FOREIGN key (employee_store_id) REFERENCES TWfood_stores(store_id)
GO
alter table TWfood_order_meals ADD
    constraint fk1_order_id foreign key (order_id) REFERENCES TWfood_orders(order_id),
    constraint fk2_meal_id FOREIGN KEY (meal_id) REFERENCES TWfood_meals(meal_id)

-- insert data
go
insert into TWfood_customers VALUES
    ('Kobe','Bryant', '2021234567', 'kb@gmail.com'),
    ('Lebron', 'James', '3152345789', 'LBJ@yahoo.com'),
    ('Stephen', 'Curry', '4102235678', 'SC30@outlook.com'),
    ('Kevin', 'Durant', '265321789', 'kd@gmail.com'),
    ('Giannis', 'Antetokounmpo', '7891234567', 'Gia34@gmail.com')
GO
insert into TWfood_meals VALUES
    ('braised pork rice', 4.99),
    ('bubble tea', 3.98),
    ('fried chicken fillet', 5.99),
    ('oyster omelet', 5.99),
    ('stinky tofu', 4.98),
    ('beef noodles', 8.99),
    ('pan-fried bun', 3.49),
    ('scallion pancake', 4.59),
    ('Taiwanese chicken nuggets', 6.89),
    ('meat ball soup', 3.98)
GO
insert into TWfood_stores VALUES
    ('LA_1', '3105676789', '110 3rd St', 'Los Angeles', 'CA'),
    ('SF_1', '4151232345', '48 Market St', 'San Francisco', 'CA'),
    ('NY_1', '3156787899', '120 West 55th St', 'New York', 'NY')
go
insert into TWfood_employees VALUES
    ('Anthony','Davis', '232324128', 'full time', 15, 'Manager', 1),
    ('Klay', 'Thompson', '123456345', 'full time', 14.5, 'Manager', 2),
    ('Kyrie', 'Irving', '345543678', 'full time', 16, 'Manager', 3),
    ('Kawhi', 'Leonard', '454678123', 'part time', 13.5, NULL, 1),
    ('Draymond', 'Green', '789876567', 'part time', 13, NULL,2),
    ('Carmelo', 'Anthony','308987678', 'part time', 14, NULL,3) 
go
insert into TWfood_orders VALUES
    ('2020-10-30 11:15:25', '2020-10-30 11:40:25', 'completed', 1, 1),
    ('2020-10-31 17:22:35', '2020-10-31 11:42:35', 'completed', 2, 1),
    ('2020-11-05 12:40:39', '2020-11-05 13:05:39', 'completed', 3, 2),
    ('2020-11-12 18:38:52', '2020-11-12 11:40:25', 'completed', 4, 3),
    ('2020-11-23 12:10:10', '2020-11-23 11:35:10', 'completed', 5, 3)
GO
insert into TWfood_ratings VALUES
    (5, 3, 1, 1),
    (4, 5, 2, 2),
    (5, 5, 5, 5)
go
insert into TWfood_order_meals VALUES
    (1,1), (1, 10), (2, 2), (3, 4), (3, 5), (4, 6), (5, 2), (5, 3), (5, 8)

-- external data model
-- calculate the total amount of each order
go
drop function if exists total_price
go
create FUNCTION total_price(
    @order_id int
) RETURNS float AS
BEGIN
    declare @sum float
    set @sum = (
        select sum(m.meal_price)
            from TWfood_order_meals om
            left join TWfood_meals m on om.meal_id = m.meal_id
            where om.order_id = @order_id
    )
    return @sum
end
go
select dbo.total_price(1)
go
-- see all the meal in one order
drop function if exists order_detail
GO
create function order_detail(
    @orderid INT
) returns table AS
return select om.order_id, m.meal_name, m.meal_price
    from TWfood_order_meals om
    left join TWfood_meals m on om.meal_id = m.meal_id
    where om.order_id = @orderid 
go
select * from order_detail(1)
-- insert the pickup time when the order status changes to completed
go
DROP TRIGGER if exists t_order_update_status
go
create trigger t_order_update_status on TWfood_orders
    after insert, UPDATE
    as BEGIN
        if (select order_status from TWfood_orders ) = 'Completed'
        update TWfood_orders
            set pickup_time = GETDATE()
            where order_id = (select max(order_id) from TWfood_orders)
end
go

select * from TWfood_ratings
select * from TWfood_orders
select * from TWfood_stores

--select GETDATE()
--select dateadd(minute, 10, getdate())