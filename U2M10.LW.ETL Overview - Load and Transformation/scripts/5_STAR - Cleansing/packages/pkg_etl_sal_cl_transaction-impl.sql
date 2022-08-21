alter session set current_schema = SAL_DW_CL;
GRANT SELECT ON SAL_DW_CL.sal_dw_cl_t_transaction TO SAL_CL;

alter session set current_schema = SAL_CL;

CREATE OR REPLACE PACKAGE body pkg_etl_sal_cl_t_transaction
AS  
  PROCEDURE load_sal_cl_t_transaction
   AS
     BEGIN
     MERGE INTO SAL_CL.sal_cl_t_transaction A
     USING ( SELECT 
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
     FROM sal_dw_cl.sal_dw_cl_t_transaction) B
             ON (a.time_ID = b.time_ID AND a.promotion_name = b.promotion_name)
             WHEN MATCHED THEN 
                UPDATE SET a.customer_name = b.customer_name
             WHEN NOT MATCHED THEN 
                INSERT (a.transaction_ID 
                        ,a.time_ID   
                    --------------------------------------------------------------------------------
                        ,a.customer_name             
                        ,a.brand_name                     
                    --------------------------------------------------------------------------------
                        ,a.agency_name                    
                        ,a.department_name                
                        ,a.agency_city                     
                        ,a.agency_country                  
                        ,a.agency_Fee_percent             
                        ,a.agency_VAT_percent               
                    --------------------------------------------------------------------------------
                        ,a.employee_passport_ID            
                        ,a.employee_first_name              
                        ,a.employee_last_name              
                        ,a.employee_position             
                        ,a.employee_email                  
                        ,a.employee_date_of_hire           
                        ,a.employee_date_end_of_contract   
                        ,a.current_flg                     
                    --------------------------------------------------------------------------------
                        ,a.promotion_name                 
                        ,a.promotion_media_type            
                        ,a.promotion_metric_amount          
                        ,a.promotion_price                 
                        ,a.promotion_KPI                   
                        ,a.promotion_distinct_percent       
                        ,a.employee_salary_project         
                    --------------------------------------------------------------------------------
                        ,a.gross_profit_dollar_amount      
                        ,a.net_profit_dollar_amount        
                        ,a.gross_revenue_dollar_amount     
                        ,a.net_revenue_dollar_amount      
                        ,a.gross_cost_dollar_amount        
                        ,a.net_cost_dollar_amount          
                        ,a.gross_salary_employee_dollar_amount 
                        ,a.net_salary_employee_dollar_amount 
                        ,a.gross_profit_margin_percent)
                VALUES (SAL_CL.SQ_sal_cl_t_transaction.NEXTVAL 
                        ,b.time_ID   
                    --------------------------------------------------------------------------------
                        ,b.customer_name             
                        ,b.brand_name                     
                    --------------------------------------------------------------------------------
                        ,b.agency_name                    
                        ,b.department_name                
                        ,b.agency_city                     
                        ,b.agency_country                  
                        ,b.agency_Fee_percent             
                        ,b.agency_VAT_percent               
                    --------------------------------------------------------------------------------
                        ,b.employee_passport_ID            
                        ,b.employee_first_name              
                        ,b.employee_last_name              
                        ,b.employee_position             
                        ,b.employee_email                  
                        ,b.employee_date_of_hire           
                        ,b.employee_date_end_of_contract   
                        ,b.current_flg                     
                    --------------------------------------------------------------------------------
                        ,b.promotion_name                 
                        ,b.promotion_media_type            
                        ,b.promotion_metric_amount          
                        ,b.promotion_price                 
                        ,b.promotion_KPI                   
                        ,b.promotion_distinct_percent       
                        ,b.employee_salary_project         
                    --------------------------------------------------------------------------------
                        ,b.gross_profit_dollar_amount      
                        ,b.net_profit_dollar_amount        
                        ,b.gross_revenue_dollar_amount     
                        ,b.net_revenue_dollar_amount      
                        ,b.gross_cost_dollar_amount        
                        ,b.net_cost_dollar_amount          
                        ,b.gross_salary_employee_dollar_amount 
                        ,b.net_salary_employee_dollar_amount 
                        ,b.gross_profit_margin_percent);
     COMMIT;
   END load_sal_cl_t_transaction;
END pkg_etl_sal_cl_t_transaction;

--------------------------------------------------------------------------------
alter session set current_schema = SAL_CL;
alter user SAL_CL QUOTA UNLIMITED ON ts_sal_cl;

EXEC pkg_etl_sal_cl_t_transaction.load_sal_cl_t_transaction;
SELECT * FROM SAL_CL.sal_cl_t_transaction order by 1;
SELECT count(*) FROM SAL_CL.sal_cl_t_transaction order by 1;
--------------------------------------------------------------------------------
--SELECT * FROM SAL_CL.sal_cl_t_transaction where promotion_name ='68251 SAMSUNG_Headphones_production' order by 1;
