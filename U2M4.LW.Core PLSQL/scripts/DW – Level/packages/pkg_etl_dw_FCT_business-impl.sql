alter session set current_schema = DW_CL;
GRANT SELECT ON DW_CL.cls_t_transaction TO DW_DATA;

alter session set current_schema = DW_DATA;

CREATE OR REPLACE PACKAGE body pkg_etl_dw_transaction
AS  
  PROCEDURE load_dw_transaction
   AS
     BEGIN 
      DECLARE
           TYPE CURSOR_VARCHAR IS TABLE OF varchar2(50);
           TYPE CURSOR_DECIMAL IS TABLE OF DECIMAL(30,2);
           TYPE CURSOR_DATE IS TABLE OF DATE;
           TYPE CURSOR_NUMBER IS TABLE OF number(10);
           
           TYPE BIG_CURSOR IS REF CURSOR;
           
           ALL_INF BIG_CURSOR;
           
           TIME_ID CURSOR_DATE;
           customer_ID CURSOR_NUMBER;
           employee_ID CURSOR_NUMBER;
           agency_ID CURSOR_NUMBER;
           gen_period_ID CURSOR_NUMBER;
           product_ID CURSOR_NUMBER;
           promotion_ID CURSOR_NUMBER;           
           Business_Fact_ID CURSOR_NUMBER;
           gross_profit_dollar_amount CURSOR_DECIMAL;            
           net_profit_dollar_amount CURSOR_DECIMAL;             
           gross_revenue_dollar_amount CURSOR_DECIMAL;         
           net_revenue_dollar_amount CURSOR_DECIMAL;           
           gross_cost_dollar_amount CURSOR_DECIMAL;             
           net_cost_dollar_amount CURSOR_DECIMAL;                
           gross_salary_employee_dollar_amount CURSOR_DECIMAL;    
           net_salary_employee_dollar_amount CURSOR_DECIMAL;     
           gross_profit_margin_percent CURSOR_DECIMAL;   

            BEGIN
                   OPEN ALL_INF FOR
                       SELECT 
                            source_CL.TIME_ID,
                            cust.customer_ID,
                            emp.employee_ID,
                            ag.agency_ID,
                            gp.gen_period_ID,
                            prod.product_ID,
                            prom.promotion_ID,
                            fct.Business_Fact_ID,
                            source_CL.gross_profit_dollar_amount,       
                            source_CL.net_profit_dollar_amount,          
                            source_CL.gross_revenue_dollar_amount,        
                            source_CL.net_revenue_dollar_amount,       
                            source_CL.gross_cost_dollar_amount,           
                            source_CL.net_cost_dollar_amount,             
                            source_CL.gross_salary_employee_dollar_amount,   
                            source_CL.net_salary_employee_dollar_amount,  
                            source_CL.gross_profit_margin_percent
                            
                          FROM (SELECT DISTINCT * FROM DW_CL.cls_t_transaction) source_CL
                                 LEFT JOIN DW_DATA.DIM_customer cust
                                   ON (source_CL.customer_name = cust.customer_name)
                                 LEFT JOIN DW_DATA.DIM_employee emp
                                   ON (source_CL.employee_passport_ID = emp.employee_passport_ID AND source_CL.employee_position = emp.employee_position)
                                LEFT JOIN DW_DATA.DIM_agency ag
                                   ON (source_CL.agency_address = ag.agency_address AND source_CL.department_name = ag.department_name)
                                LEFT JOIN DW_DATA.DIM_gen_period gp
                                   ON (source_CL.promotion_name = gp.promotion_name AND source_CL.promotion_start = gp.promotion_start)
                                LEFT JOIN DW_DATA.DIM_product prod
                                   ON (source_CL.brand_name = prod.brand_name AND source_CL.product_name = prod.product_name)
                                LEFT JOIN DW_DATA.DIM_promotion prom
                                   ON (source_CL.time_id = prom.time_id AND source_CL.promotion_name = prom.promotion_name)
                                LEFT JOIN DW_DATA.FCT_business fct
                                   ON (cust.customer_ID=fct.customer_ID 
                         AND emp.employee_id=fct.employee_id 
                         AND ag.agency_id=fct.agency_id 
                         AND gp.gen_period_id=fct.gen_period_id 
                         AND prod.product_id=fct.product_id 
                         AND prom.promotion_id=fct.promotion_id 
                         AND prom.time_id=fct.time_id 
                         AND source_CL.gross_profit_dollar_amount=fct.gross_profit_dollar_amount
                         AND source_CL.net_profit_dollar_amount=fct.net_profit_dollar_amount
                         AND source_CL.gross_revenue_dollar_amount=fct.gross_revenue_dollar_amount
                         AND source_CL.net_revenue_dollar_amount=fct.net_revenue_dollar_amount
                         AND source_CL.gross_cost_dollar_amount=fct.gross_cost_dollar_amount
                         AND source_CL.net_cost_dollar_amount=fct.net_cost_dollar_amount
                         AND source_CL.gross_salary_employee_dollar_amount=fct.gross_salary_employee_dollar_amount
                         AND source_CL.net_salary_employee_dollar_amount=fct.net_salary_employee_dollar_amount
                         AND source_CL.gross_profit_margin_percent=fct.gross_profit_margin_percent
                       );
                   FETCH ALL_INF
                   BULK COLLECT INTO
                                TIME_ID,
                                customer_ID,
                                employee_ID,
                                agency_ID,
                                gen_period_ID,
                                product_ID,
                                promotion_ID,
                                Business_Fact_ID,
                                gross_profit_dollar_amount,           
                                net_profit_dollar_amount,        
                                gross_revenue_dollar_amount,       
                                net_revenue_dollar_amount,         
                                gross_cost_dollar_amount,         
                                net_cost_dollar_amount,               
                                gross_salary_employee_dollar_amount,   
                                net_salary_employee_dollar_amount,   
                                gross_profit_margin_percent;                     
                   CLOSE ALL_INF;
           
FOR i IN Business_Fact_ID.FIRST .. Business_Fact_ID.LAST LOOP

       IF ( Business_Fact_ID ( i ) IS NULL ) THEN
          INSERT INTO DW_DATA.FCT_business ( 
                                            Business_Fact_ID,     
                                            TIME_ID,
                                            customer_ID,
                                            employee_ID,
                                            agency_ID,
                                            gen_period_ID,
                                            product_ID,
                                            promotion_ID,
                                            gross_profit_dollar_amount,
                                            net_profit_dollar_amount,
                                            gross_revenue_dollar_amount,
                                            net_revenue_dollar_amount,
                                            gross_cost_dollar_amount,
                                            net_cost_dollar_amount,
                                            gross_salary_employee_dollar_amount,
                                            net_salary_employee_dollar_amount,
                                            gross_profit_margin_percent)
               VALUES ( DW_DATA.SQ_FCT_business.NEXTVAL,
                                            TIME_ID(i),
                                            customer_ID(i),
                                            employee_ID(i),
                                            agency_ID(i),
                                            gen_period_ID(i),
                                            product_ID(i),
                                            promotion_ID(i),
                                            ROUND(gross_profit_dollar_amount(i),2),
                                            ROUND(net_profit_dollar_amount(i),2),
                                            ROUND(gross_revenue_dollar_amount(i),2),
                                            ROUND(net_revenue_dollar_amount(i),2),
                                            ROUND(gross_cost_dollar_amount(i),2),
                                            ROUND(net_cost_dollar_amount(i),2),
                                            ROUND(gross_salary_employee_dollar_amount(i),2),
                                            ROUND(net_salary_employee_dollar_amount(i),2),
                                            ROUND(gross_profit_margin_percent(i),2)                        
                        );
          COMMIT;
              
       END IF;
 
    END LOOP;
	  
	END;
   END load_dw_transaction;
END pkg_etl_dw_transaction;

--------------------------------------------------------------------------------
alter session set current_schema = DW_DATA;
alter user DW_DATA QUOTA UNLIMITED ON TS_DW_DATA_01;

EXEC pkg_etl_dw_transaction.load_dw_transaction;

SELECT * from DW_DATA.FCT_business;

SELECT * from DW_DATA.FCT_business ORDER BY 1;

SELECT * from DW_DATA.FCT_business where promotion_id = 219504;

SELECT count(*) FROM DW_DATA.FCT_business;

--------------------------------------------------------------------------------
