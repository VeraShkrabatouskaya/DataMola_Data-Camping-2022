--drop table DW_DATA.DIM_product;
--alter session set current_schema = DW_DATA;

CREATE TABLE DW_DATA.DIM_product(
    product_ID NUMBER(10),     
    brand_name           VARCHAR2(50),
    product_name         VARCHAR2(50),
    category_name        VARCHAR2(50),
    subcategory_name     VARCHAR2(50),
 
    CONSTRAINT "PK_T.DIM_product" PRIMARY KEY(product_ID) 
);

select * from DW_DATA.DIM_product;
select * from DW_DATA.DIM_product where product_id = 13;
