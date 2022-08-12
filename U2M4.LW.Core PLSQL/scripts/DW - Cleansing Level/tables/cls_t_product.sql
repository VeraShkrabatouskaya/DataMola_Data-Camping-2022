--alter session set current_schema=DW_CL;
--drop table cls_t_product;

alter session set current_schema=DW_CL;

Create table cls_t_product (
    brand_name           VARCHAR2(50) NOT NULL,
    product_name         VARCHAR2(50) NOT NULL,
    category_name        VARCHAR2(50) NOT NULL,
    subcategory_name     VARCHAR2(50) NOT NULL
);
