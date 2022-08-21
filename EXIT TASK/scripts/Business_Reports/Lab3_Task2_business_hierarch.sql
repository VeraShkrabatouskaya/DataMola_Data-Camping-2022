--GRANT UNLIMITED TABLESPACE TO VShkrabatovskaya;
--SELECT * from dba_data_files ;
--select * from USER_tablespaces;

alter session set current_schema=sa_customers;
alter user sa_customers QUOTA UNLIMITED ON ts_sa_customers_data_01;

select * from sa_customers.SA_CUSTOMER_DATA_total
order by 1;

select * from sa_customers.sa_customer_data_pr;

select * from sa_customers.SA_CUSTOMER_DATA_total left outer join sa_customers.sa_customer_data_pr on sa_customers.SA_CUSTOMER_DATA_total.product_name=sa_customers.sa_customer_data_pr.product_name
order by 1;

--DROP TABLE business_hierarch
Create table business_hierarch as 
select SA_CUSTOMER_DATA_total.total_ID, SA_CUSTOMER_DATA_total.brand_name, SA_CUSTOMER_DATA_total.product_name, sa_customer_data_pr.category_name, sa_customer_data_pr.subcategory_name from SA_CUSTOMER_DATA_total left outer join sa_customer_data_pr on SA_CUSTOMER_DATA_total.product_name=sa_customer_data_pr.product_name
order by 1;

select * from business_hierarch;

--DROP TABLE promotion_objects;
CREATE TABLE promotion_objects(
    object_item VARCHAR2(100),
    object_parent_item VARCHAR2(100)
) TABLESPACE ts_sa_customers_data_01;

INSERT INTO promotion_objects (object_item, object_parent_item)
    SELECT category_name || ' category_name', null 
 FROM business_hierarch
GROUP BY category_name;
--delete from promotion_objects where object_parent_item is null;

INSERT INTO promotion_objects (object_item, object_parent_item)
    SELECT product_name|| ' product_name', category_name || ' category_name'
    FROM business_hierarch
    GROUP BY product_name|| ' product_name', category_name || ' category_name';

INSERT INTO promotion_objects(object_item, object_parent_item)
    SELECT subcategory_name ||  ' subcategory_name', product_name || ' product_name'
        FROM business_hierarch
    GROUP BY  subcategory_name ||  ' subcategory_name', product_name || ' product_name';

--delete from promotion_objects where object_item = 'SAMSUNG' or object_item = 'VISA';
INSERT INTO promotion_objects(object_item, object_parent_item)
    SELECT brand_name,
      subcategory_name ||  ' subcategory_name'
    FROM business_hierarch
    GROUP BY brand_name, subcategory_name ||  ' subcategory_name';

SELECT * FROM promotion_objects;

CREATE TABLE t_levels_by_category
AS
    SELECT LPAD(' ',4* LEVEL, ' ') || object_item AS levels_by_category,
       DECODE(( SELECT COUNT(*)FROM promotion_objects t1 WHERE t1.object_parent_item = t2.object_item),0,NULL,
             ( SELECT COUNT(*) FROM promotion_objects t1 WHERE t1.object_parent_item = t2.object_item)) AS count_child,
       DECODE(LEVEL, 1, 'ROOT', 4, 'LEAF', 'BRANCH') AS id_type,
       LEVEL AS lvl,
       CONNECT_BY_ROOT(object_item) AS root,
       SYS_CONNECT_BY_PATH(object_item, '-->') AS path,
       REGEXP_SUBSTR(SYS_CONNECT_BY_PATH(object_item, '-->'), '-->([^(-->)]+)', 1, 1, NULL, 1) AS Level1,
       REGEXP_SUBSTR(SYS_CONNECT_BY_PATH(object_item, '-->'), '-->([^(-->)]+)', 1, 2, NULL, 1) AS Level2,
       REGEXP_SUBSTR(SYS_CONNECT_BY_PATH(object_item, '-->'), '-->([^(-->)]+)', 1, 3, NULL, 1) AS Level3,
       REGEXP_SUBSTR(SYS_CONNECT_BY_PATH(object_item, '-->'), '-->([^(-->)]+)', 1, 4, NULL, 1) AS Level4
    FROM promotion_objects t2
    START WITH object_parent_item IS NULL
    CONNECT BY PRIOR object_item = object_parent_item
    ORDER SIBLINGS BY object_item;

--DROP table t_levels_by_category;

SELECT * FROM t_levels_by_category;
