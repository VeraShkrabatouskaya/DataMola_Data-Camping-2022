--Lab6_Task_1 Using Analytic Functions: FIRST_VALUE, LAST_VALUE
alter session set current_schema=DW_CL;
GRANT SELECT ON DW_CL.cls_t_transaction TO DW_DATA;
alter session set current_schema=DW_DATA;

select * from DW_CL.cls_t_transaction;
select count(*) from DW_CL.cls_t_transaction;

--Information about the types of media that brought in the highest profits, by city.
SELECT 
    agency_city,
    promotion_media_type,
    sum_profit, 
    FIRST_VALUE(promotion_media_type) 
        OVER (
            PARTITION BY agency_city
            ORDER BY sum_profit DESC
        ) as HIGHEST_PROFIT_media_type
FROM (
select agency_city, promotion_media_type, sum(net_profit_dollar_amount) as sum_profit
from DW_CL.cls_t_transaction
GROUP BY  agency_city, promotion_media_type
ORDER BY agency_city,promotion_media_type)
ORDER BY sum_profit DESC;  

--Information about the types of media that brought in the lowest profits, by city.
SELECT 
    agency_city,
    promotion_media_type,
    sum_profit, 
    LAST_VALUE(promotion_media_type) 
        OVER (
            PARTITION BY agency_city
            ORDER BY sum_profit DESC
            RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
        ) as LOWEST_PROFIT_media_type
FROM (
select agency_city, promotion_media_type, sum(net_profit_dollar_amount) as sum_profit
from DW_CL.cls_t_transaction
GROUP BY  agency_city, promotion_media_type
ORDER BY agency_city,promotion_media_type)
ORDER BY sum_profit DESC;  
