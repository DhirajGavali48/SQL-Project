create database cable;
use cable;
drop table customers;
create table customers (
user_id int not null unique,
first_name varchar(50),
last_name varchar(50),
mobile_number int8);
describe customers;

drop table recharge_pack;
create table recharge_pack(
user_id int not null ,
pack varchar(50),
price int);

drop table invoice;
create table invoice(
user_id int not null,
Account_no int)
Loc_name varchar(255);

drop table address;
create table address(
user_id int not null,
city varchar(50));

ALTER TABLE invoice
ADD Loc_name varchar(255);

select * from customers;
insert into customers (user_id,first_name,last_name,mobile_number)
values(1,'pankaj','gavali',8605566746),
(2,'mayur','gavali',9850541320),
(3,'jagdish','gavali',9850589320),
(4,'aaru','dayre',9850541390),
(5,'rudra','patil',7850541320),
(6,'jayshree','gavali',9889561320),
(7,'jay','tare',8965231445),
(8,'raj','mali',9850541850),
(9,'ram','zanje',9350541320),
(10,'hari','gavali',963251320),
(11,'atharva','dighe',8321441320),
(12,'chinu','zanje',9850591320),
(13,'divensh','dayare',9850510080),
(14,'om','gavali',9850541327),
(15,'dinesh','tare',9850000320),
(16,'akshya','kadav',6580541320),
(17,'nilesh','harad',9640541320),
(18,'mahesh','patil',8945541320),
(19,'rutik','kadam',7412541320),
(20,'krish','gavali',8523541320);

select * from recharge_pack;
insert into recharge_pack (user_id,pack,price)
values(1,'DSN DIAMOND',520),
(1,'DSN SILVER MARATHI 1',300),
(2,'DSN SILVER MARATHI 2',360),
(3,'DSN GOLD',410),
(4,'DSN MINI MARATHI SILVER',231),
(5,'DSN DIAMOND',520),
(6,'DSN GOLD',410),
(7,'DSN DIAMOND',520),
(8,'DSN MINI MARATHI SILVER',231),
(9,'DSN DIAMOND',520),
(10,'DSN GOLD',410),
(11,'DSN SILVER MARATHI 2',360),
(12,'DSN DIAMOND',520),
(13,'DSN MINI MARATHI SILVER',231),
(14,'DSN DIAMOND',520),
(15,'DSN DIAMOND',520),
(16,'DSN MINI MARATHI SILVER',231),
(17,'DSN DIAMOND',520),
(18,'DSN GOLD',410),
(19,'DSN DIAMOND',520),
(20,'DSN MINI MARATHI SILVER',231),
(2,'DSN DIAMOND',520),
(3,'DSN MINI MARATHI SILVER',231),
(4,'DSN DIAMOND',520),
(13,'DSN GOLD',410),
(16,'DSN GOLD',410);

select * from invoice;
insert into invoice (user_id,Account_no,Loc_name)
values(1,1303225952,'JAI CHEDOBA CABLE NETWORK'),
(2,1303225953,'JAI CHEDOBA CABLE NETWORK'),
(3,1303225954,'JAI CHEDOBA CABLE NETWORK'),
(4,1303225955,'JAI CHEDOBA CABLE NETWORK'),
(5,1303225956,'JAI CHEDOBA CABLE NETWORK'),
(6,1303225957,'JAI CHEDOBA CABLE NETWORK'),
(7,1303225958,'JAI CHEDOBA CABLE NETWORK'),
(8,1303225959,'JAI CHEDOBA CABLE NETWORK'),
(9,1303225951,'JAI CHEDOBA CABLE NETWORK'),
(10,1303225962,'JAI CHEDOBA CABLE NETWORK'),
(11,1303225972,'JAI CHEDOBA CABLE NETWORK'),
(12,1303225982,'JAI CHEDOBA CABLE NETWORK'),
(13,1303225992,'JAI CHEDOBA CABLE NETWORK'),
(14,1303225942,'JAI CHEDOBA CABLE NETWORK'),
(15,1303225932,'JAI CHEDOBA CABLE NETWORK'),
(16,1303225922,'JAI CHEDOBA CABLE NETWORK'),
(17,1303225912,'JAI CHEDOBA CABLE NETWORK'),
(18,1303245952,'JAI CHEDOBA CABLE NETWORK'),
(18,1303255952,'JAI CHEDOBA CABLE NETWORK'),
(20,1303265952,'JAI CHEDOBA CABLE NETWORK');

select * from address;
insert into address (user_id,city)
values(1,'manivali'),
(2,'varai'),
(3,'avsare'),
(4,'manivali'),
(5,'varai'),
(6,'manivali'),
(7,'varai'),
(8,'manivali'),
(9,'varai'),
(10,'manivali'),
(11,'varai'),
(12,'manivali'),
(13,'avsare'),
(14,'manivali'),
(15,'varai'),
(16,'manivali'),
(17,'avsare'),
(18,'varai'),
(19,'manivali'),
(20,'avsare');

select * from customers;
select * from recharge_pack;
Select * from invoice;
select * from address;

## Give the detail of customer who live in manivali? sub-query
SELECT *
FROM customers
WHERE user_id in (SELECT user_id FROM address WHERE city = 'manivali');

## what is the full name of customer whoes has has gold pack? join

SELECT c.user_id, CONCAT(c.first_name, ' ', c.last_name) AS full_name
FROM customers c
JOIN recharge_pack rp ON c.user_id = rp.user_id
WHERE rp.pack = 'DSN GOLD';

# who customer are purchse more than 1 pack and give me there account no?

SELECT r.user_id, i.Account_no, c.first_name,last_name, COUNT(r.pack) AS num_packs_purchased
FROM recharge_pack r
JOIN invoice i ON i.user_id = r.user_id
JOIN customers c ON c.user_id = r.user_id
GROUP BY r.user_id, i.Account_no, c.first_name
HAVING num_packs_purchased > 1;

#Identify the pack names for which the price is higher than the average price across all packs.
SELECT user_id,pack
FROM recharge_pack
WHERE price > (SELECT AVG(price) FROM recharge_pack);

## give all imformaion of customers?

SELECT c.user_id, c.first_name, c.last_name, c.mobile_number, r.pack, r.price, i.account_no, a.city
FROM customers c
JOIN recharge_pack r ON c.user_id = r.user_id
JOIN invoice i ON c.user_id = i.user_id
JOIN address a ON c.user_id = a.user_id;

# what is total price of each pack ?
SELECT pack, SUM(price) AS total_price
FROM recharge_pack
GROUP BY pack
ORDER BY total_price DESC;
 
##give the detail of customers who has max price pack in varai ? 
SELECT c.user_id, c.first_name, c.last_name,r.price, a.city
FROM customers c
JOIN recharge_pack r ON c.user_id = r.user_id
JOIN invoice i ON c.user_id = i.user_id
JOIN address a ON c.user_id = a.user_id
where price=(SELECT max(price) FROM recharge_pack WHERE city="varai");



##Retrieve the names of customers who have made a recharge and have an invoice, along with the total amount spent.
SELECT customers.first_name, customers.last_name, SUM(recharge_pack.price) AS total_amount_spent
FROM customers
INNER JOIN recharge_pack ON customers.user_id = recharge_pack.user_id
INNER JOIN invoice ON customers.user_id = invoice.user_id
GROUP BY customers.user_id, customers.first_name, customers.last_name;

##Find the total number of customers in each city.
SELECT address.city, COUNT(customers.user_id) AS total_customers
FROM address
LEFT JOIN customers ON address.user_id = customers.user_id
GROUP BY address.city;

##List the names of customers who have made a recharge of more than 400.
SELECT customers.first_name,customers.last_name
FROM customers
INNER JOIN recharge_pack ON customers.user_id = recharge_pack.user_id
WHERE recharge_pack.price > 400;

##List the names of customers along with the total amount spent on recharge packs.
SELECT first_name, last_name,
    (SELECT SUM(price) FROM recharge_pack WHERE user_id = customers.user_id) AS total_amount_spent
FROM customers;

##give the names of customers who live in the 'avsare' city and have an invoice.
SELECT first_name, last_name
FROM customers
WHERE user_id IN (
    SELECT customers.user_id
    FROM customers
    INNER JOIN address ON customers.user_id = address.user_id
    INNER JOIN invoice ON customers.user_id = invoice.user_id
    WHERE address.city = 'avsare'
);