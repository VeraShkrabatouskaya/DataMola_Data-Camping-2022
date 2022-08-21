--Lab6_Task_2 Using Analytic Functions: RANK, DENSE_RANK, ROWNUM
alter session set current_schema=DW_CL;
GRANT SELECT ON DW_CL.cls_t_transaction TO DW_DATA;
alter session set current_schema=DW_DATA;

select * from DW_CL.cls_t_transaction;
select count(*) from DW_CL.cls_t_transaction;

--Information about the ranks of the categories of advertised products and the total amount of advertising costs by product.  
select product_name, total_costs, category_name,
         rank() over (order by category_name DESC) as RANK_product,
         DENSE_RANK () over (order by category_name DESC) as DENSE_RANK_product,
         ROW_NUMBER() over (order by category_name DESC) as ROW_NUMBER_product
FROM (
SELECT product_name, SUM (net_cost_dollar_amount) as total_costs, category_name
FROM DW_CL.cls_t_transaction
GROUP BY product_name, category_name
ORDER BY total_costs DESC);
