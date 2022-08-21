--GRANT UNLIMITED TABLESPACE TO VShkrabatovskaya;
--GRANT CONNECT,RESOURCE TO sa_customers;
--SELECT * from dba_data_files ;
--select * from USER_tablespaces;
alter session set current_schema=sa_customers;
alter user sa_customers QUOTA UNLIMITED ON ts_sa_customers_data_01;

--alter session set current_schema=sa_customers;
--GRANT SELECT ON SA_CUSTOMER_DATA_total TO DW_CL;

alter session set current_schema=sa_customers;
GRANT SELECT ON SA_CUSTOMER_DATA_with_department TO DW_CL;
--------------------------------
--DROP TABLE sa_customer_data_c;
CREATE TABLE SA_CUSTOMER_DATA_c
(
    customer_name            VARCHAR2(50),
    brand_name               VARCHAR2(50),
    customer_address         VARCHAR2(50),
    customer_city            VARCHAR2(30),
    customer_country         VARCHAR2(30),
    customer_email           VARCHAR2(50),
    customer_office_phone    VARCHAR2(30),
    customer_mobile_phone    VARCHAR2(30)
)
TABLESPACE ts_sa_customers_data_01;

INSERT INTO sa_customer_data_c (
    customer_name,
    brand_name, 
    customer_address,
    customer_city,
    customer_country,
    customer_email,
    customer_office_phone,
    customer_mobile_phone
    )
VALUES (
'Samsung Electronics',
'SAMSUNG',
'85 Challenger Rd. Ridgefield Park',
'New Jersey',
'United States',
'www.facebook.com/SamsungUS',
'1-201-229-4000',
'1-201-229-4029');

select * from sa_customer_data_c;
--------------------------------------------------------------------------------
--DROP TABLE sa_customer_data_p;
CREATE TABLE SA_CUSTOMER_DATA_p
(
    product_name             VARCHAR2(50)
)
TABLESPACE ts_sa_customers_data_01;

INSERT INTO sa_customer_data_p (product_name) VALUES ('Refrigerators');
INSERT INTO sa_customer_data_p (product_name) VALUES ('Ovens');
INSERT INTO sa_customer_data_p (product_name) VALUES ('Cooking ovens');
INSERT INTO sa_customer_data_p (product_name) VALUES ('Washing machines');
INSERT INTO sa_customer_data_p (product_name) VALUES ('Dishwashers');
INSERT INTO sa_customer_data_p (product_name) VALUES ('Microwave ovens');
INSERT INTO sa_customer_data_p (product_name) VALUES ('Vacuum Cleaners');
INSERT INTO sa_customer_data_p (product_name) VALUES ('Smart watches');
INSERT INTO sa_customer_data_p (product_name) VALUES ('TVs');
INSERT INTO sa_customer_data_p (product_name) VALUES ('Smartphones');
INSERT INTO sa_customer_data_p (product_name) VALUES ('Headphones');
INSERT INTO sa_customer_data_p (product_name) VALUES ('Tablets');

select * from sa_customer_data_p;
--------------------------------------------------------------------------------
 select sa_customer_data_c.*, sa_customer_data_p.*
 from sa_customer_data_c, sa_customer_data_p;
--------------------------------------------------------------------------------
--DROP TABLE sa_customer_data_c2;
CREATE TABLE SA_CUSTOMER_DATA_c2
(
    customer_name            VARCHAR2(50),
    brand_name               VARCHAR2(50),
    customer_address         VARCHAR2(50),
    customer_city            VARCHAR2(30),
    customer_country         VARCHAR2(30),
    customer_email           VARCHAR2(50),
    customer_office_phone    VARCHAR2(30),
    customer_mobile_phone    VARCHAR2(30)
)
TABLESPACE ts_sa_customers_data_01;

INSERT INTO sa_customer_data_c2 (
    customer_name,
    brand_name, 
    customer_address,
    customer_city,
    customer_country,
    customer_email,
    customer_office_phone,
    customer_mobile_phone
    )
VALUES (
'Visa International Service Association',
'VISA',
'900 Metro Center Blvd.',
'Foster City',
'United States',
'https://usa.visa.com/contact-us.html',
'1-800-847-2911',
'1-800-847-2922');

select * from sa_customer_data_c2;
--------------------------------------------------------------------------------
--DROP TABLE sa_customer_data_p2;
CREATE TABLE SA_CUSTOMER_DATA_p2
(
    product_name             VARCHAR2(50)
)
TABLESPACE ts_sa_customers_data_01;

INSERT INTO sa_customer_data_p2 (product_name) VALUES ('Sponsorship');
INSERT INTO sa_customer_data_p2 (product_name) VALUES ('Card');
INSERT INTO sa_customer_data_p2 (product_name) VALUES ('Benefit');
INSERT INTO sa_customer_data_p2 (product_name) VALUES ('Service');

select * from sa_customer_data_p2;
--------------------------------------------------------------------------------
 select sa_customer_data_c2.*, sa_customer_data_p2.*
 from sa_customer_data_c2, sa_customer_data_p2;
--------------------------------------------------------------------------------
--DROP TABLE sa_customer_data_a;
CREATE TABLE SA_CUSTOMER_DATA_a
(
    agency_name              VARCHAR2(50),
    agency_city              VARCHAR2(30),
    agency_country           VARCHAR2(30),
    agency_address           VARCHAR2(50),
    agency_postcode          VARCHAR2(6),
    agency_email             VARCHAR2(30),
    agency_office_phone      VARCHAR2(30),
    agency_mobile_phone      VARCHAR2(30),
    agency_Fee_percent       DECIMAL (10,2),
    agency_VAT_percent       DECIMAL (10,2)
)
TABLESPACE ts_sa_customers_data_01;

INSERT INTO SA_CUSTOMER_DATA_a
VALUES (
'Starcom',
'New York',
'United States',
'375 Hudson St. Floor 12',
'10014',
'www.starcomww.com/contact',
'1-212-468-3888',
'1-212-468-3588',
5,
15
)
;

INSERT INTO SA_CUSTOMER_DATA_a
VALUES (
'Starcom',
'Sydney',
'Australia',
'21 Harris Street, Pyrmont',
'2009',
'www.starcomww.com/contact',
'612-8666-8000',
'612-8666-8010',
1,
25.8
)
;

INSERT INTO SA_CUSTOMER_DATA_a
VALUES (
'Starcom',
'Paris',
'France',
'30-34 chemin Vert Street',
'75011',
'www.starcomww.com/contact',
'33-1-58-74-08-68',
'33-1-58-74-78-66',
2,
20
)
;

INSERT INTO SA_CUSTOMER_DATA_a
VALUES (
'Starcom',
'Zurich',
'Switzerland',
'Stadelhoferstrasse 258',
'8001',
'www.starcomww.com/contact',
'41-43-366-61-61',
'41-43-366-66-66',
2,
7.7
)
;


INSERT INTO SA_CUSTOMER_DATA_a
VALUES (
'Starcom',
'Nocosia',
'Cyprus',
'21 Academias Ave. KEMA Building',
'2107',
'www.starcomww.com/contact',
'357-22378828',
'357-22378833',
7,
19
)
;

INSERT INTO SA_CUSTOMER_DATA_a
VALUES (
'Starcom',
'Hong Kong',
'China',
'29/F, Paul Y. Centre 51 Hung To Road Kwun Tong',
'12345',
'www.starcomww.com/contact',
'39-051-77-44-90',
'34-911-99-37-11',
5,
13
)
;

INSERT INTO SA_CUSTOMER_DATA_a
VALUES (
'Starcom',
'Berlin',
'Germany',
'Paul Lincke Ufer 39-40',
'10999',
'www.starcomww.com/contact',
'49-211-5684962',
'49-211-5684962',
3,
19
)
;

INSERT INTO SA_CUSTOMER_DATA_a
VALUES (
'Starcom',
'Shanghai',
'China',
'21/F Henderson 688',
'12345',
'www.starcomww.com/contact',
'39-051-77-55-90',
'39-051-77-99-90',
5,
13
)
;

INSERT INTO SA_CUSTOMER_DATA_a
VALUES (
'Starcom',
'Cairo',
'Egypt',
'City Stars 4th Floor',
'10521',
'www.starcomww.com/contact',
'202-0-2-4800-941',
'202-0-5-4800-941',
5,
14  
)
;   

INSERT INTO SA_CUSTOMER_DATA_a
VALUES (
'Starcom',
'Warsaw',
'Poland',
'44 A Domaniewska Street',
'02-672',
'www.starcomww.com/contact',
'48-22-493-99-99',
'48-22-493-09-99',
8,
23 
)
; 

INSERT INTO SA_CUSTOMER_DATA_a
VALUES (
'Starcom',
'Barcelona',
'Spain',
'385 Aragon Street',
'08013',
'www.starcomww.com/contact',
'34-933-96-77-00',
'34-933-96-88-00',
9,
21 
)
; 

INSERT INTO SA_CUSTOMER_DATA_a
VALUES (
'Starcom',
'Milan',
'Italy',
'C.R. Darwin Street, 20',
'20143',
'www.starcomww.com/contact',
'39-02-66-798-1',
'39-02-66-798-2',
2,
22 
)
;

INSERT INTO SA_CUSTOMER_DATA_a
VALUES (
'Starcom',
'Dubai',
'UAE',
'King Salman Bin Abdulaziz Al Saud St.',
'7534',
'www.starcomww.com/contact',
'971-0-4-367-6400',
'971-0-4-367-6411',
4,
5
)
; 

INSERT INTO SA_CUSTOMER_DATA_a
VALUES (
'Starcom',
'Moscow',
'Russia',
'15 Leningradsky prospekt, bld 1',
'194021',
'www.starcomww.com/contact',
'7-495-969-2010',
'7-495-969-2011',
7,
20
)
; 

INSERT INTO SA_CUSTOMER_DATA_a
VALUES (
'Starcom',
'London',
'United Kingdom',
'2 Television Centre, 101 Wood Lane',
'19721',
'www.starcomww.com/contact',
'44-204-577-43-17',
'44-204-577-43-17',
5,
20
)
; 
--delete from sa_customer_data_a where agency_city in ('Chicago')
select AGENCY_COUNTRY from sa_customer_data_a;
--------------------------------------------------------------------------------
CREATE TABLE SA_CUSTOMER_DATA_pm
(
    promotion_media_type    VARCHAR2(50)
)
TABLESPACE ts_sa_customers_data_01;
--DROP TABLE sa_customer_data_pm;

INSERT INTO SA_CUSTOMER_DATA_pm (promotion_media_type) VALUES ('TV');
INSERT INTO SA_CUSTOMER_DATA_pm (promotion_media_type) VALUES ('press');
INSERT INTO SA_CUSTOMER_DATA_pm (promotion_media_type) VALUES ('digital');
INSERT INTO SA_CUSTOMER_DATA_pm (promotion_media_type) VALUES ('radio');
INSERT INTO SA_CUSTOMER_DATA_pm (promotion_media_type) VALUES ('OOH');
INSERT INTO SA_CUSTOMER_DATA_pm (promotion_media_type) VALUES ('production');
INSERT INTO SA_CUSTOMER_DATA_pm (promotion_media_type) VALUES ('design');


select * from SA_CUSTOMER_DATA_pm;

--delete from SA_CUSTOMER_DATA_pm where promotion_media_type in ('TV')
--------------------------------------------------
--DROP TABLE SA_CUSTOMER_DATA_total;
create table SA_CUSTOMER_DATA_total
(
TOTAL_ID NUMBER (10),
TIME_ID DATE,
CUSTOMER_NAME varchar2 (50),
BRAND_NAME VARCHAR2(50),
CUSTOMER_ADDRESS VARCHAR2(50),
CUSTOMER_CITY VARCHAR2(30),
CUSTOMER_COUNTRY VARCHAR2(30),
CUSTOMER_EMAIL VARCHAR2(50),
CUSTOMER_OFFICE_PHONE VARCHAR2(30),
CUSTOMER_MOBILE_PHONE VARCHAR2(30),
PRODUCT_NAME VARCHAR2(50),
AGENCY_NAME VARCHAR2(50),
AGENCY_CITY VARCHAR2(30),
AGENCY_COUNTRY VARCHAR2(30),
AGENCY_ADDRESS VARCHAR2(50),
AGENCY_POSTCODE VARCHAR2(6),
AGENCY_EMAIL VARCHAR2(30),
AGENCY_OFFICE_PHONE VARCHAR2(30),
AGENCY_MOBILE_PHONE VARCHAR2(30),
AGENCY_FEE_PERCENT DECIMAL (10,2),
AGENCY_VAT_PERCENT DECIMAL (10,2),
PROMOTION_MEDIA_TYPE VARCHAR2(30)
)
TABLESPACE ts_sa_customers_data_01;

INSERT INTO  SA_CUSTOMER_DATA_total
with cte_customer_agency AS (
    select  sa_customer_data_c.*, sa_customer_data_p.*, sa_customer_data_a.*, SA_CUSTOMER_DATA_pm.*
    from  sa_customer_data_c, sa_customer_data_p, sa_customer_data_a, SA_CUSTOMER_DATA_pm
    union all
    select  sa_customer_data_c2.*, sa_customer_data_p2.*, sa_customer_data_a.*, SA_CUSTOMER_DATA_pm.*
    from  sa_customer_data_c2, sa_customer_data_p2, sa_customer_data_a,SA_CUSTOMER_DATA_pm
    ), 
    SA_CUSTOMER_DATA AS (
    select ROW_NUMBER() OVER (ORDER BY TIME_ID) total_ID, t.*, cte_customer_agency.*
    from (
        SELECT 
        TRUNC( sd + rn ) time_id
        FROM
             ( 
               SELECT 
               TO_DATE( '12/31/2021', 'MM/DD/YYYY' ) sd,
               rownum rn
               FROM dual
               CONNECT BY level <= 200
              )
      ) t, 
      cte_customer_agency
    order by TOTAL_ID DESC)
select * from SA_CUSTOMER_DATA;

select * from SA_CUSTOMER_DATA_total
order by 1;

select DISTINCT (agency_city) from SA_CUSTOMER_DATA_total
order by 1;

with cte_customer_agency AS (
    select  sa_customer_data_c.*, sa_customer_data_p.*, sa_customer_data_a.*, SA_CUSTOMER_DATA_pm.*
    from  sa_customer_data_c, sa_customer_data_p, sa_customer_data_a, SA_CUSTOMER_DATA_pm
    union all
    select  sa_customer_data_c2.*, sa_customer_data_p2.*, sa_customer_data_a.*, SA_CUSTOMER_DATA_pm.*
    from  sa_customer_data_c2, sa_customer_data_p2, sa_customer_data_a,SA_CUSTOMER_DATA_pm
    ), 
    CUSTOMER_DATA AS (
    select ROW_NUMBER() OVER (ORDER BY TIME_ID) total_ID, t.*, cte_customer_agency.*
    from (
        SELECT 
        TRUNC( sd + rn ) time_id
        FROM
             ( 
               SELECT 
               TO_DATE( '12/31/2021', 'MM/DD/YYYY' ) sd,
               rownum rn
               FROM dual
               CONNECT BY level <= 200
              )
      ) t, 
      cte_customer_agency
    order by TOTAL_ID ASC)
select count(*) from CUSTOMER_DATA;
      
with cte_customer_agency AS (
    select  sa_customer_data_c.*, sa_customer_data_p.*, sa_customer_data_a.*, SA_CUSTOMER_DATA_pm.*
    from  sa_customer_data_c, sa_customer_data_p, sa_customer_data_a, SA_CUSTOMER_DATA_pm
    union all
    select  sa_customer_data_c2.*, sa_customer_data_p2.*, sa_customer_data_a.*, SA_CUSTOMER_DATA_pm.*
    from  sa_customer_data_c2, sa_customer_data_p2, sa_customer_data_a,SA_CUSTOMER_DATA_pm
    ), 
    CUSTOMER_DATA AS (
    select ROW_NUMBER() OVER (ORDER BY TIME_ID) total_ID, t.*, cte_customer_agency.*
    from (
        SELECT 
        TRUNC( sd + rn ) time_id
        FROM
             ( 
               SELECT 
               TO_DATE( '12/31/2021', 'MM/DD/YYYY' ) sd,
               rownum rn
               FROM dual
               CONNECT BY level <= 200
              )
      ) t, 
      cte_customer_agency
    order by TOTAL_ID ASC)
select distinct(CUSTOMER_DATA.agency_city) from CUSTOMER_DATA;
--------------------------------------------------------------------------------
--GROUP BY
--------------------------------------------------------------------------------
with cte_customer_agency AS (
    select  sa_customer_data_c.*, sa_customer_data_p.*, sa_customer_data_a.*, SA_CUSTOMER_DATA_pm.*
    from  sa_customer_data_c, sa_customer_data_p, sa_customer_data_a, SA_CUSTOMER_DATA_pm
    union all
    select  sa_customer_data_c2.*, sa_customer_data_p2.*, sa_customer_data_a.*, SA_CUSTOMER_DATA_pm.*
    from  sa_customer_data_c2, sa_customer_data_p2, sa_customer_data_a,SA_CUSTOMER_DATA_pm
    ), 
    CUSTOMER_DATA AS (
    select ROW_NUMBER() OVER (ORDER BY TIME_ID) total_ID, t.*, cte_customer_agency.*
    from (
        SELECT 
        TRUNC( sd + rn ) time_id
        FROM
             ( 
               SELECT 
               TO_DATE( '12/31/2021', 'MM/DD/YYYY' ) sd,
               rownum rn
               FROM dual
               CONNECT BY level <= 200
              )
      ) t, 
      cte_customer_agency
    order by TOTAL_ID ASC)
select CUSTOMER_DATA.brand_name, CUSTOMER_DATA.promotion_media_type  from CUSTOMER_DATA
GROUP BY CUSTOMER_DATA.brand_name, CUSTOMER_DATA.promotion_media_type;

--------------------------------------------------------------------------------
with cte_customer_agency AS (
    select  sa_customer_data_c.*, sa_customer_data_p.*, sa_customer_data_a.*, SA_CUSTOMER_DATA_pm.*
    from  sa_customer_data_c, sa_customer_data_p, sa_customer_data_a, SA_CUSTOMER_DATA_pm
    union all
    select  sa_customer_data_c2.*, sa_customer_data_p2.*, sa_customer_data_a.*, SA_CUSTOMER_DATA_pm.*
    from  sa_customer_data_c2, sa_customer_data_p2, sa_customer_data_a,SA_CUSTOMER_DATA_pm
    ), 
    CUSTOMER_DATA AS (
    select ROW_NUMBER() OVER (ORDER BY TIME_ID) total_ID, t.*, cte_customer_agency.*
    from (
        SELECT 
        TRUNC( sd + rn ) time_id
        FROM
             ( 
               SELECT 
               TO_DATE( '12/31/2021', 'MM/DD/YYYY' ) sd,
               rownum rn
               FROM dual
               CONNECT BY level <= 200
              )
      ) t, 
      cte_customer_agency
    order by TOTAL_ID ASC)
select CUSTOMER_DATA.agency_country, CUSTOMER_DATA.agency_city, CUSTOMER_DATA.brand_name, CUSTOMER_DATA.promotion_media_type  from CUSTOMER_DATA
GROUP BY CUSTOMER_DATA.agency_country, CUSTOMER_DATA.agency_city, CUSTOMER_DATA.brand_name, CUSTOMER_DATA.promotion_media_type;
--------------------------------------------------------------------------------
--MERGE

select * from sa_customer_data_c;
select * from sa_customer_data_c2;
 
MERGE INTO sa_customer_data_c t1
USING sa_customer_data_c2 t2
ON (t1.customer_name = t2.customer_name)
WHEN MATCHED THEN
UPDATE SET
t1.brand_name = t2.brand_name,
t1.customer_address = t2.customer_address,
t1.customer_city = t2.customer_city,
t1.customer_country = t2.customer_country,
t1.customer_email = t2.customer_email,
t1.customer_office_phone = t2.customer_office_phone,
t1.customer_mobile_phone = t2.customer_mobile_phone
WHEN NOT MATCHED THEN
INSERT (t1.customer_name, t1.brand_name, t1.customer_address, t1.customer_city, t1.customer_country, t1.customer_email,t1.customer_office_phone, t1.customer_mobile_phone)
VALUES (t2.customer_name, t2.brand_name, t2.customer_address, t2.customer_city, t2.customer_country, t2.customer_email,t2.customer_office_phone, t2.customer_mobile_phone);

select * from sa_customer_data_c t1;
select * from sa_customer_data_c2 t2;

--Drop table sa_customer_data_c;
--Drop table sa_customer_data_c2;
--------------------------------------------------------------------------------
--DROP TABLE SA_CUSTOMER_DATA_pr;
CREATE TABLE SA_CUSTOMER_DATA_pr
(
    product_ID            Number (10),
    brand_name            VARCHAR2(50),
    product_name               VARCHAR2(50),
    category_name         VARCHAR2(50),
    subcategory_name            VARCHAR2(50)
)
TABLESPACE ts_sa_customers_data_01;

INSERT INTO SA_CUSTOMER_DATA_pr (
    product_ID,
    brand_name,
    product_name, 
    category_name,
    subcategory_name
    )
VALUES (
1,
'SAMSUNG',
'Refrigerators',
'Appliances',
'Fridge'
);

INSERT INTO SA_CUSTOMER_DATA_pr (
    product_ID,
    brand_name,
    product_name, 
    category_name,
    subcategory_name
    )
VALUES (
2,
'SAMSUNG',
'Ovens',
'Appliances',
'Conventional ovens'
);

INSERT INTO SA_CUSTOMER_DATA_pr (
    product_ID,
    brand_name,
    product_name, 
    category_name,
    subcategory_name
    )
VALUES (
3,
'SAMSUNG',
'Cooking ovens',
'Appliances',
'Electric cooktop'
);

INSERT INTO SA_CUSTOMER_DATA_pr (
    product_ID,
    brand_name,
    product_name, 
    category_name,
    subcategory_name
    )
VALUES (
4,
'SAMSUNG',
'Washing machines',
'Appliances',
'Fully Automatic washing machine'
);

INSERT INTO SA_CUSTOMER_DATA_pr (
    product_ID,
    brand_name,
    product_name, 
    category_name,
    subcategory_name
    )
VALUES (
5,
'SAMSUNG',
'Dishwashers',
'Appliances',
'Built-in Dishwasher'
);

INSERT INTO SA_CUSTOMER_DATA_pr (
    product_ID,
    brand_name,
    product_name, 
    category_name,
    subcategory_name
    )
VALUES (
6,
'SAMSUNG',
'Microwave ovens',
'Appliances',
'Convection Microwave'
);

INSERT INTO SA_CUSTOMER_DATA_pr (
    product_ID,
    brand_name,
    product_name, 
    category_name,
    subcategory_name
    )
VALUES (
7,
'SAMSUNG',
'Vacuum Cleaners',
'Appliances',
'Robotic vacuum cleaner'
);

INSERT INTO SA_CUSTOMER_DATA_pr (
    product_ID,
    brand_name,
    product_name, 
    category_name,
    subcategory_name
    )
VALUES (
8,
'SAMSUNG',
'Smart watches',
'Computerized wristwatch',
'Smart watch for kids?'
);

INSERT INTO SA_CUSTOMER_DATA_pr (
    product_ID,
    brand_name,
    product_name, 
    category_name,
    subcategory_name
    )
VALUES (
9,
'SAMSUNG',
'TVs',
'Appliances',
'QLED'
);

INSERT INTO SA_CUSTOMER_DATA_pr (
    product_ID, 
    brand_name,
    product_name, 
    category_name,
    subcategory_name
    )
VALUES (
10,
'SAMSUNG',
'Smartphones',
'Phones',
'Android Phones'
);

INSERT INTO SA_CUSTOMER_DATA_pr (
    product_ID,
    brand_name,
    product_name, 
    category_name,
    subcategory_name
    )
VALUES (
11,
'SAMSUNG',
'Headphones',
'Accessories',
'Earbuds'
);

INSERT INTO SA_CUSTOMER_DATA_pr (
    product_ID,
    brand_name,
    product_name, 
    category_name,
    subcategory_name
    )
VALUES (
12,
'SAMSUNG',
'Tablets',
'Tablet computer',
'Galaxy Tab series?'
);

INSERT INTO SA_CUSTOMER_DATA_pr (
    product_ID,
    brand_name,
    product_name, 
    category_name,
    subcategory_name
    )
VALUES (
16,
'VISA',
'Sponsorship',
'Services',
'Networking sponsor'
);

INSERT INTO SA_CUSTOMER_DATA_pr (
    product_ID,
    brand_name,
    product_name, 
    category_name,
    subcategory_name
    )
VALUES (
13,
'VISA',
'Card',
'Services',
'Contactless smart card'
);

INSERT INTO SA_CUSTOMER_DATA_pr (
    product_ID,
    brand_name,
    product_name, 
    category_name,
    subcategory_name
    )
VALUES (
14,
'VISA',
'Benefit',
'Services',
'Retirement Savings'
);

INSERT INTO SA_CUSTOMER_DATA_pr (
    product_ID,
    brand_name,
    product_name, 
    category_name,
    subcategory_name
    )
VALUES (
15,
'VISA',
'Service',
'Services',
'Internet banks'
);

select * from sa_customer_data_pr;
--delete from sa_customer_data_pr where product_name = 'Dishwasher'

select * from SA_CUSTOMER_DATA_total
order by 1;

select * from SA_CUSTOMER_DATA_total left outer join sa_customer_data_pr on SA_CUSTOMER_DATA_total.product_name=sa_customer_data_pr.product_name
order by 1;

--DROP TABLE SA_CUSTOMER_DATA_with_department;
CREATE TABLE SA_CUSTOMER_DATA_with_department AS
select 
SA_CUSTOMER_DATA_total.*, 
sa_customer_data_pr.category_name, sa_customer_data_pr.subcategory_name,
    CASE WHEN promotion_media_type = 'TV' THEN 'Media Planning and Buying'
         WHEN promotion_media_type = 'digital' THEN 'Media Planning and Buying'
         WHEN promotion_media_type = 'press' THEN 'Media Planning and Buying'
         WHEN promotion_media_type = 'radio' THEN 'Media Planning and Buying'
         WHEN promotion_media_type = 'OOH' THEN 'Out-of-Home Media'
         WHEN promotion_media_type = 'design' THEN 'Art and Visualization'
         WHEN promotion_media_type = 'production' THEN 'Production'
    END AS department_name
FROM SA_CUSTOMER_DATA_total left outer join sa_customer_data_pr on SA_CUSTOMER_DATA_total.product_name=sa_customer_data_pr.product_name
ORDER BY 1;

select distinct department_name from SA_CUSTOMER_DATA_with_department;

select * from SA_CUSTOMER_DATA_with_department;
select count(*) from SA_CUSTOMER_DATA_with_department;
    
--------------------------------------------------------------------------------

--drop TABLESPACE ts_sa_customers_data_01 INCLUDING CONTENTS AND DATAFILES CASCADE CONSTRAINTS;
--select segment_name, segment_type from user_segments;
--PURGE RECYCLEBIN;
