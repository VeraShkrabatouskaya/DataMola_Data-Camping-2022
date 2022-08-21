alter session set current_schema=DW_DATA;
GRANT SELECT ON DW_DATA.FCT_business TO SAL_DW_CL;
GRANT SELECT ON DW_DATA.DIM_customer TO SAL_DW_CL;
GRANT SELECT ON DW_DATA.DIM_employee TO SAL_DW_CL;
GRANT SELECT ON DW_DATA.DIM_agency TO SAL_DW_CL;
GRANT SELECT ON DW_DATA.DIM_promotion TO SAL_DW_CL;

alter session set current_schema = SAL_DW_CL;

CREATE OR REPLACE PACKAGE body pkg_etl_sal_dw_cl_transaction
AS  
  PROCEDURE load_sal_dw_cl_transaction
   AS
      CURSOR cursor_sal_dw_cl_transaction
      IS
         SELECT DISTINCT fct_b.time_ID
--------------------------------------------------------------------------------
                        ,cust.customer_name
                        ,cust.brand_name             
--------------------------------------------------------------------------------                        
                        ,ag.agency_name      
                        ,ag.department_name  
                        ,ag.agency_city               
                        ,ag.agency_country                   
                        ,ag.agency_Fee_percent              
                        ,ag.agency_VAT_percent              
--------------------------------------------------------------------------------
                        ,emp.employee_passport_ID          
                        ,emp.employee_first_name              
                        ,emp.employee_last_name              
                        ,emp.employee_position               
                        ,emp.employee_email                
                        ,emp.employee_date_of_hire          
                        ,emp.employee_date_end_of_contract    
                        ,emp.current_flg                     
--------------------------------------------------------------------------------
                        ,prom.promotion_name                   
                        ,prom.promotion_media_type             
                        ,prom.promotion_metric_amount         
                        ,prom.promotion_price                 
                        ,prom.promotion_KPI                 
                        ,prom.promotion_distinct_percent       
                        ,prom.employee_salary_project         
--------------------------------------------------------------------------------
                        ,fct_b.gross_profit_dollar_amount     
                        ,fct_b.net_profit_dollar_amount        
                        ,fct_b.gross_revenue_dollar_amount      
                        ,fct_b.net_revenue_dollar_amount        
                        ,fct_b.gross_cost_dollar_amount        
                        ,fct_b.net_cost_dollar_amount           
                        ,fct_b.gross_salary_employee_dollar_amount 
                        ,fct_b.net_salary_employee_dollar_amount 
                        ,fct_b.gross_profit_margin_percent
           FROM DW_DATA.FCT_business fct_b
           left join DW_DATA.DIM_customer cust on fct_b.customer_ID = cust.customer_ID
           left join DW_DATA.DIM_employee emp on fct_b.employee_ID = emp.employee_ID
           left join DW_DATA.DIM_agency ag on fct_b.agency_ID = ag.agency_ID
           left join DW_DATA.DIM_promotion prom on fct_b.promotion_ID = prom.promotion_ID
           WHERE fct_b.time_ID IS NOT NULL 
--------------------------------------------------------------------------------
                        AND cust.customer_name IS NOT NULL
                        AND cust.brand_name IS NOT NULL   
--------------------------------------------------------------------------------                        
                        AND ag.agency_name IS NOT NULL      
                        AND ag.department_name IS NOT NULL  
                        AND ag.agency_city IS NOT NULL               
                        AND ag.agency_country IS NOT NULL                   
                        AND ag.agency_Fee_percent IS NOT NULL              
                        AND ag.agency_VAT_percent IS NOT NULL              
--------------------------------------------------------------------------------
                        AND emp.employee_passport_ID IS NOT NULL          
                        AND emp.employee_first_name IS NOT NULL              
                        AND emp.employee_last_name IS NOT NULL              
                        AND emp.employee_position IS NOT NULL               
                        AND emp.employee_email IS NOT NULL                
                        AND emp.employee_date_of_hire IS NOT NULL          
                        AND emp.employee_date_end_of_contract IS NOT NULL    
                        AND emp.current_flg IS NOT NULL                     
--------------------------------------------------------------------------------
                        AND prom.promotion_name IS NOT NULL                   
                        AND prom.promotion_media_type IS NOT NULL             
                        AND prom.promotion_metric_amount IS NOT NULL         
                        AND prom.promotion_price IS NOT NULL                 
                        AND prom.promotion_KPI IS NOT NULL                 
                        AND prom.promotion_distinct_percent IS NOT NULL       
                        AND prom.employee_salary_project IS NOT NULL         
--------------------------------------------------------------------------------
                        AND fct_b.gross_profit_dollar_amount IS NOT NULL     
                        AND fct_b.net_profit_dollar_amount IS NOT NULL        
                        AND fct_b.gross_revenue_dollar_amount IS NOT NULL      
                        AND fct_b.net_revenue_dollar_amount IS NOT NULL        
                        AND fct_b.gross_cost_dollar_amount IS NOT NULL        
                        AND fct_b.net_cost_dollar_amount IS NOT NULL           
                        AND fct_b.gross_salary_employee_dollar_amount IS NOT NULL 
                        AND fct_b.net_salary_employee_dollar_amount IS NOT NULL 
                        AND fct_b.gross_profit_margin_percent IS NOT NULL                      
                 ;
  
   BEGIN
      EXECUTE IMMEDIATE 'TRUNCATE TABLE SAL_DW_CL.sal_dw_cl_t_transaction';
      FOR i IN cursor_sal_dw_cl_transaction LOOP
         INSERT INTO SAL_DW_CL.sal_dw_cl_t_transaction( 
                         time_ID
--------------------------------------------------------------------------------
                        ,customer_name
                        ,brand_name   
--------------------------------------------------------------------------------
                        ,agency_name      
                        ,department_name  
                        ,agency_city               
                        ,agency_country                   
                        ,agency_Fee_percent              
                        ,agency_VAT_percent              
--------------------------------------------------------------------------------
                        ,employee_passport_ID          
                        ,employee_first_name              
                        ,employee_last_name              
                        ,employee_position               
                        ,employee_email                
                        ,employee_date_of_hire          
                        ,employee_date_end_of_contract    
                        ,current_flg                     
--------------------------------------------------------------------------------
                        ,promotion_name                   
                        ,promotion_media_type             
                        ,promotion_metric_amount         
                        ,promotion_price                 
                        ,promotion_KPI                 
                        ,promotion_distinct_percent       
                        ,employee_salary_project         
--------------------------------------------------------------------------------
                        ,gross_profit_dollar_amount     
                        ,net_profit_dollar_amount        
                        ,gross_revenue_dollar_amount      
                        ,net_revenue_dollar_amount        
                        ,gross_cost_dollar_amount        
                        ,net_cost_dollar_amount           
                        ,gross_salary_employee_dollar_amount 
                        ,net_salary_employee_dollar_amount 
                        ,gross_profit_margin_percent     
                        )    
              VALUES ( 
                         i.time_ID
--------------------------------------------------------------------------------
                        ,i.customer_name
                        ,i.brand_name 
--------------------------------------------------------------------------------
                        ,i.agency_name      
                        ,i.department_name  
                        ,i.agency_city               
                        ,i.agency_country                   
                        ,i.agency_Fee_percent              
                        ,i.agency_VAT_percent              
--------------------------------------------------------------------------------
                        ,i.employee_passport_ID          
                        ,i.employee_first_name              
                        ,i.employee_last_name              
                        ,i.employee_position               
                        ,i.employee_email                
                        ,i.employee_date_of_hire          
                        ,i.employee_date_end_of_contract    
                        ,i.current_flg                     
--------------------------------------------------------------------------------
                        ,i.promotion_name                   
                        ,i.promotion_media_type             
                        ,i.promotion_metric_amount         
                        ,i.promotion_price                 
                        ,i.promotion_KPI                 
                        ,i.promotion_distinct_percent       
                        ,i.employee_salary_project         
--------------------------------------------------------------------------------
                        ,i.gross_profit_dollar_amount     
                        ,i.net_profit_dollar_amount        
                        ,i.gross_revenue_dollar_amount      
                        ,i.net_revenue_dollar_amount        
                        ,i.gross_cost_dollar_amount        
                        ,i.net_cost_dollar_amount           
                        ,i.gross_salary_employee_dollar_amount 
                        ,i.net_salary_employee_dollar_amount 
                        ,i.gross_profit_margin_percent
                        );  
         EXIT WHEN cursor_sal_dw_cl_transaction%NOTFOUND;
      END LOOP;

      COMMIT;
   END load_sal_dw_cl_transaction;
END pkg_etl_sal_dw_cl_transaction;
--------------------------------------------------------------------------------
alter session set current_schema = SAL_DW_CL;
alter user SAL_DW_CL QUOTA UNLIMITED ON ts_dw_str_cls;

EXEC pkg_etl_sal_dw_cl_transaction.load_sal_dw_cl_transaction;

SELECT * FROM sal_dw_cl_t_transaction
order by 1;

SELECT count(*) FROM sal_dw_cl_t_transaction

--SELECT * FROM sal_dw_cl_t_transaction where promotion_name = '1515 VISA_Benefit_digital' order by 1 ;
--------------------------------------------------------------------------------
