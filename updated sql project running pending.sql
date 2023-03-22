SELECT * FROM flipkart_analysis2.flipkart_table;
use flipkart_analysis2; -- Database
SELECT * FROM flipkart_table;
alter table flipkart_table change column ï»¿Name Brand varchar(30);

-- Total brands,Total models
select count(distinct Brand) Total_brand,count( distinct Model) Total_model,
count(Brand) Total_phones from flipkart_table;

 -- Count all 5G model
 select count(Model)Total_5G_Models from flipkart_table where Model like '%5G';

-- most reviewed colour
select count(brand) brand_count,colour from flipkart_table group by colour order by brand_count desc; 
-- FOUND black colour got maximum reviews

-- most reviewed Brand
select Brand,count(brand) brand_count,round(avg(Rating),1) as Avg_rating from 
flipkart_table group by Brand order by brand_count desc ; 
-- redmi & realme are highest reviewed brands

-- most expensive phones
select * from flipkart_table where Current_Price = (select max(Current_Price) from flipkart_table);
--  Apple phones are most expensive (black,blue & pink colour)

-- avg crnt price of each colour
select colour,avg(Current_Price) cp from flipkart_table group by Colour order by cp desc ;

 -- self join
select t1.Brand,t2.Model from flipkart_table t1 join flipkart_table t2 on t1.Model = t2. Model;

-- Average rating of each Brand
select Brand,round(avg(Rating),1) rating from flipkart_table group by Brand order by rating desc;
-- google phones are high in average rating

-- Total reviews , average price of each ROM 
select ROM as Internal_GB ,count(ROM) Total_Reviews ,avg(current_price) avg_price  FROM flipkart_table 
group by ROM order by Total_Reviews desc;
-- people like 128 & 64 GB ROM as compare to 256 or 32 GB

-- highest rated Brands & models
select Brand,Model,Rating from flipkart_table where Rating = (select max(Rating) from flipkart_table) group by Brand;
-- high rated brands are MOTOROLA,vivo,REDMI,SAMSUNG,Infinix,OPPO

-- Max current price of each brand
select f.*,max(Current_price) over (partition by brand order by Rating desc) 
as max_c_price from flipkart_table f;
 
 -- first two most expensive phones of each brand
select * from ( select f.* ,row_number () over (partition by brand order by current_price desc) as rn
 from flipkart_table f) x where x.rn <3 ;
 
 -- Rank of top 3 Model of each brand with highest rating
 select * from ( select f.* ,rank () over (partition by brand order by Rating desc) as rnk
 from flipkart_table f) x where x.rnk <4 ;
 
 -- creating a view
create view flipkart_view as select brand,Model,current_price,colour,rating from flipkart_table;
select * from flipkart_view;

--  budget phone : phone of price under 23000 with 4.4 rating ,black in colour
select * from flipkart_table where Current_Price <=23000 and Rating >4.4 and Colour = 'black'
order by current_price desc;

-- found:
-- use aggregation(countdistinct,max,avg),where,group by,order by, win func-- row number,rank,self join
--  Black is the most reviewed colour
-- redmi & realme are highest reviewed brands
-- Apple phones are most expensive (black,blue & pink colour)
-- people like 128 & 64 GB ROM as compare to 256 or 32 GB
-- Google phones are highest rated Brand in avg rating(4.5)
-- high rated brands(4.7) are MOTOROLA,vivo,REDMI,SAMSUNG,Infinix,OPPO
-- first two most expensive phones of each brand using row number
-- Rank of top 3 Model of each brand with highest rating using rank
-- found 18 budget phones with good rating & black in colour.
