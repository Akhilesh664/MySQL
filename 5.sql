
--
-- Create schema demo_db
--

CREATE DATABASE IF NOT EXISTS demo_db;
USE demo_db;

DROP TABLE IF EXISTS brands;
CREATE TABLE brands (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int(10) unsigned NOT NULL,
  `brand` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;

select * from brands;

--
-- Dumping data for table `brands`
--

-- !40000 ALTER TABLE `brands` DISABLE KEYS 
INSERT INTO `brands` (`id`,`product_id`,`brand`) VALUES 
 (1,383741444,'Fujifilm'),
 (2,383741454,'Fujifilm'),
 (3,383741464,'Fujifilm'),
 (4,383741474,'Fujifilm'),
 (5,383741484,'Olympus'),
 (6,383741494,'Olympus'),
 (7,383750454,'Fujifilm'),
 (8,383751734,'Panasonic'),
 (9,383751744,'Panasonic'),
 (10,383751754,'Panasonic'),
 (11,383751824,'Panasonic'),
 (12,383751834,'Panasonic'),
 (13,383751844,'Panasonic');
-- !40000 ALTER TABLE `brands` ENABLE KEYS

select * from brands;
 
--
-- Definition of table `invoices`
--

DROP TABLE IF EXISTS `invoices`;
CREATE TABLE `invoices` (
  `region_id` varchar(100) NOT NULL,
  `value` float(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

select * from invoices;


--
-- Dumping data for table `invoices`
--

INSERT INTO `invoices` (`region_id`,`value`) VALUES 
 ('region1',573.44),
 ('region1',145.54),
 ('region1',417.84),
 ('region1',203.89),
 ('region1',301.14),
 ('region1',340.04),
 ('region1',495.64),
 ('region1',515.09),
 ('region1',398.39),
 ('region2',262.24),
 ('region2',437.29),
 ('region2',320.59),
 ('region2',242.79),
 ('region2',184.44),
 ('region2',164.99),
 ('region2',612.34),
 ('region2',476.19),
 ('region2',281.69),
 ('region3',359.49),
 ('region3',378.94),
 ('region3',592.89),
 ('region3',534.54),
 ('region3',223.34),
 ('region3',456.74),
 ('region3',553.99);

select * from invoices;


--
-- Definition of table `order_lines`
--

DROP TABLE IF EXISTS `order_lines`;
CREATE TABLE `order_lines` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL,
  `product_id` int(10) unsigned NOT NULL,
  `quantity` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;

select * from order_lines;

--
-- Dumping data for table `order_lines`
--

INSERT INTO `order_lines` (`id`,`order_id`,`product_id`,`quantity`) VALUES 
 (1,1,383741444,1),
 (2,1,383741484,1),
 (3,2,383751754,1),
 (4,2,383741494,2),
 (5,2,383741464,1),
 (6,3,383751754,1),
 (7,4,383741444,2),
 (8,4,383741464,3),
 (9,5,383751844,1),
 (10,5,383741494,1),
 (11,6,383751754,1),
 (12,6,383741444,2),
 (13,6,383751744,1),
 (14,7,383741494,1),
 (15,7,383751844,1),
 (16,7,383741464,1),
 (17,7,383751754,1);

select * from order_lines;
 
 
--
-- Definition of table `orders`
--

DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_date` datetime NOT NULL,
  `order_value` float(10,2) NOT NULL,
  `order_status` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

select * from orders;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`,`order_date`,`order_value`,`order_status`) VALUES 
 (1,'2012-02-09 20:26:31',240.00,'ORDERED'),
 (2,'2012-02-09 20:28:00',475.00,'ORDERED'),
 (3,'2012-02-09 20:34:05',115.00,'ORDERED'),
 (4,'2012-02-09 20:39:35',600.00,'ORDERED'),
 (5,'2012-02-09 20:52:30',280.00,'ORDERED'),
 (6,'2012-02-09 20:53:18',470.00,'ORDERED'),
 (7,'2012-02-09 20:55:47',515.00,'ORDERED');
 
select * from orders;
 
--
-- Definition of table `products`
--

DROP TABLE IF EXISTS `products`;
CREATE TABLE `products` (
  `product_id` int(20) NOT NULL DEFAULT '0',
  `product_name` varchar(200) DEFAULT NULL,
  `price` float(10,2) DEFAULT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

select * from products;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`,`product_name`,`price`) VALUES 
 (383741444,'Fuji 16MP Digital Camera - Black',120.00),
 (383741454,'Fuji 16MP Digital Camera - Silver',120.00),
 (383741464,'Fuji 16MP Digital Camera - Pink',120.00),
 (383741474,'Fuji 16MP Digital Camera - Red',120.00),
 (383741484,'Olympus 14MP Digital Camera Black',120.00),
 (383741494,'Olympus 14MP Digital Camera Silver',120.00),
 (383750454,'Fuji 14MP 30x Optical Zoom Camera',120.00),
 (383751734,'Panasonic 14MP Digital Camera Blue',115.00),
 (383751744,'Panasonic 14MP Digital Camera Red',115.00),
 (383751754,'Panasonic 14MP Digital Camera Pink',115.00),
 (383751824,'Panasonic 16MP Digital Camera Black',160.00),
 (383751834,'Panasonic 16MP Digital Camera Silver',160.00),
 (383751844,'Panasonic 16MP Digital Camera Red',160.00);
 
 select * from products;
 

 
-- 1) find out the top 3 product_id based on quntity sold?
select * from order_lines;

select product_id, sum(quantity) as Total_quantity
from order_lines
group by 
	product_id
order by Total_quantity desc
limit 3;

-- 2) get order_date, product_id, product_name, order_id which has bessn sold in the multilple of 2?
select * from products;
select * from orders;
select * from order_lines;

-- select o.order_date, ol.product_id, p.product_name, ol.order_id
-- from order_lines ol
-- join orders o on ol.order_id = o.id
-- join products p on ol.product_id = p.product_id
-- where ol.quantity % 2 = 0;

-- OR
select o.order_date, ol.product_id, prod.product_name, ol.order_id
from orders as o 
join order_lines ol 
	on o.id = ol.order_id
join products as prod 
	on ol.product_id = prod.product_id
where (ol.quantity % 2 = 0);



-- 3) get the brand name, order value, product_name for each product sold?
select * from brands;
select * from orders;
select * from products;
select * from order_lines;

select b.brand, o.order_value, p.product_name
from order_lines ol
join orders o on ol.order_id = o.id
join products p on ol.product_id = p.product_id
join brands b on p.product_id = b.product_id;

-- select b.brand, o.order_value, p.product_name
-- from  oreder_lines as ol
-- join orders as o 
-- 	on ol.order_id = o_id
-- join products as p
-- 	on p.product_id =  ol.product_id
-- join brands as b
-- on ol.product_id =  b.product_id;



-- 4) get the avg orderValue for each order which has bear placed after half mn hour?
select * from order_lines;

select avg(o.order_value) as avg_order_value
from orders o
where timestampdiff(minute, '2012-02-09 20:00:00', o.order_date) > 30;

-- OR
-- select avg(ord.order_value) as AverageOrderValue
-- from orders ord
-- where 
-- 	timestamp(minute, 
-- 				'2012-02-09 20:00:00', o.order_date) >= 30;


-- 5) get the order_id the no. of quantities for each brand?
select * from order_lines;
select * from brands;
 
select ol.order_id, sum(ol.quantity) as total_quantity, b.brand as brandName
from order_lines ol
JOIN products p 
	ON ol.product_id = p.product_id
JOIN brands b 
	ON p.product_id = b.product_id
GROUP BY ol.order_id,b.brand;

-- select ol.order_id, sum(ol.quantity) as total_quantity, b.brand as brandName
-- from order_lines ol
-- join brands b 
-- 	on ol.product_id = b.product_id
-- group by 
-- 	b.brand;


-- ================= on SalesData imported from csv file 
use demo_db;
select * from salesdata;

-- 1) Get all transactions done for the "Beauty" category in December

select *
from salesdata
where 
	categoryProduct = "Beauty"	
    and 
		month(STR_TO_DATE(sales_date,'%m/%d/%Y'))=12
		or
		month(STR_TO_DATE(sales_date,'%m-%d-%Y'))=12;
		
        
-- 2) Get the total sales done for each category in each month
select * from salesdata;

-- select categoryProduct, month(sales_date) as month, year(sales_date) as year, sum(total_sale) as TotalSales
-- FROM salesdata
-- GROUP BY 
-- 	categoryProduct, year, month;

-- or
SELECT categoryProduct, MONTH(STR_TO_DATE(sales_date, '%m/%d/%Y')) AS month, 
       YEAR(STR_TO_DATE(sales_date, '%m/%d/%Y')) AS year, 
       SUM(total_sale) AS total_sales
FROM salesdata
GROUP BY categoryProduct, year, month
ORDER BY year, month;

-- Find the maximum, minimum, and average age of people buying beauty products
select * from salesdata;

-- select max(year(curdate()) - year(age)) as maximumAge,
-- min(year(curdate()) - year(age)) as minumumAge,
-- avg(year(curdate()) - year(age)) as AverageAge
-- from salesdata
-- where categoryProduct = "Beauty";

-- or
SELECT MAX(YEAR(CURRENT_DATE) - YEAR(STR_TO_DATE(age, '%d-%m-%Y'))) AS max_age,
       MIN(YEAR(CURRENT_DATE) - YEAR(STR_TO_DATE(age, '%d-%m-%Y'))) AS min_age,
       AVG(YEAR(CURRENT_DATE) - YEAR(STR_TO_DATE(age, '%d-%m-%Y'))) AS avg_age
FROM salesdata
WHERE categoryProduct = 'Beauty';

-- 4) Get the number of transactions done by each user in each category
select * from salesdata;

-- select categoryProduct, count(*) AS TotalTransaction
-- from salesdata
-- group by categoryProduct;

-- or
SELECT customer_id, categoryProduct, COUNT(*) AS total_transactions
FROM salesdata
GROUP BY customer_id, categoryProduct
ORDER BY customer_id;

-- 5) Find the best-selling month for each year along with the average sales for each month
select * from salesdata;

WITH monthly_sales AS (
    SELECT YEAR(STR_TO_DATE(sales_date, '%m/%d/%Y')) AS year, 
           MONTH(STR_TO_DATE(sales_date, '%m/%d/%Y')) AS month,
           SUM(total_sale) AS total_sales
    FROM salesdata
    GROUP BY year, month
),
average_sales AS (
    SELECT year, month, AVG(total_sales) AS avg_monthly_sales
    FROM monthly_sales
    GROUP BY year, month
)
SELECT year, month, MAX(total_sales) AS best_selling_month, 
       avg_monthly_sales
FROM monthly_sales
JOIN average_sales USING (year, month)
GROUP BY year, month
ORDER BY year, month;

-- 6) Get the top 3 and bottom 3 customers based on their average sales Get the top 3 and bottom 3 customers based on their average sales
select * from salesdata;

WITH customer_sales AS (
    SELECT customer_id, AVG(total_sale) AS avg_sales
    FROM salesdata
    GROUP BY customer_id
)
SELECT customer_id, avg_sales
FROM customer_sales
ORDER BY avg_sales DESC
LIMIT 3
UNION ALL
SELECT customer_id, avg_sales
FROM customer_sales
ORDER BY avg_sales ASC
LIMIT 3;

-- 7) Get the number of unique customers who purchased products for each category
select * from salesdata;

select categoryProduct, count(distinct customer_id) as customrer
from salesdata
group by categoryProduct;


-- 8) Count orders placed in different time slots
-- i) Orders placed from morning to 1 PM:

SELECT COUNT(*) AS morning_orders
FROM salesdata
WHERE TIME(STR_TO_DATE(time, '%H:%i:%s')) BETWEEN '00:00:00' AND '13:00:00';

-- ii) Orders placed during lunch time (1 PM to 3 PM):

SELECT COUNT(*) AS lunch_orders
FROM salesdata
WHERE TIME(STR_TO_DATE(time, '%H:%i:%s')) BETWEEN '13:00:00' AND '15:00:00';

-- iii)Orders placed in the evening after 5 PM:

SELECT COUNT(*) AS evening_orders
FROM salesdata
WHERE TIME(STR_TO_DATE(time, '%H:%i:%s')) >= '17:00:00';