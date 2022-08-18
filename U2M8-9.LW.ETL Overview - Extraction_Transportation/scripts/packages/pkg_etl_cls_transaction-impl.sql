alter session set current_schema=sa_promotions;
GRANT SELECT ON SA_TRANSACTION_FACT_DATA TO DW_CL;

alter session set current_schema = DW_CL;

CREATE OR REPLACE PACKAGE body pkg_etl_cls_transaction
AS  
  PROCEDURE load_cls_transaction
   AS
      CURSOR cursor_cls_transaction
      IS
         SELECT DISTINCT time_ID
                        ,customer_name
                        ,brand_name                       
                        ,customer_address                 
                        ,customer_city                    
                        ,customer_country                
                        ,customer_email                  
                        ,customer_office_phone            
                        ,customer_mobile_phone           
                        ,product_name                    
                        ,agency_name                   
                        ,agency_city                     
                        ,agency_country                  
                        ,agency_address                   
                        ,agency_postcode                 
                        ,agency_email                    
                        ,agency_office_phone             
                        ,agency_mobile_phone           
                        ,agency_Fee_percent              
                        ,agency_VAT_percent              
                        ,promotion_media_type            
                        ,category_name                   
                        ,subcategory_name                
                        ,department_name                 
                        ,employee_first_name              
                        ,employee_last_name              
                        ,employee_position               
                        ,employee_salary_project        
                        ,employee_passport_ID           
                        ,employee_email                  
                        ,employee_office_phone            
                        ,employee_mobile_phone           
                        ,employee_date_of_hire           
                        ,employee_date_end_of_contract    
                        ,promotion_metric_amount        
                        ,promotion_price                  
                        ,promotion_KPI                  
                        ,promotion_distinct_percent       
                        ,promotion_name                   
                        ,promotion_start                 
                        ,promotion_end 
                        ,gross_revenue_dollar_amount
                        ,net_revenue_dollar_amount        
                        ,gross_cost_dollar_amount        
                        ,net_cost_dollar_amount           
                        ,gross_profit_dollar_amount       
                        ,net_profit_dollar_amount        
                        ,net_salary_employee_dollar_amount 
                        ,gross_salary_employee_dollar_amount 
                        ,gross_profit_margin_percent         
           FROM sa_promotions.SA_TRANSACTION_FACT_DATA
           WHERE time_ID IS NOT NULL 
                         AND customer_name IS NOT NULL 
                         AND brand_name IS NOT NULL                        
                         AND customer_address IS NOT NULL                 
                         AND customer_city IS NOT NULL                    
                         AND customer_country IS NOT NULL                
                         AND customer_email IS NOT NULL                  
                         AND customer_office_phone IS NOT NULL            
                         AND customer_mobile_phone IS NOT NULL           
                         AND product_name IS NOT NULL                    
                         AND agency_name IS NOT NULL                   
                         AND agency_city IS NOT NULL                      
                         AND agency_country IS NOT NULL                  
                         AND agency_address IS NOT NULL                   
                         AND agency_postcode IS NOT NULL                 
                         AND agency_email IS NOT NULL                    
                         AND agency_office_phone IS NOT NULL             
                         AND agency_mobile_phone IS NOT NULL           
                         AND agency_Fee_percent IS NOT NULL              
                         AND agency_VAT_percent IS NOT NULL              
                         AND promotion_media_type IS NOT NULL            
                         AND category_name IS NOT NULL                   
                         AND subcategory_name IS NOT NULL                
                         AND department_name IS NOT NULL                 
                         AND employee_first_name IS NOT NULL              
                         AND employee_last_name IS NOT NULL              
                         AND employee_position IS NOT NULL               
                         AND employee_salary_project IS NOT NULL        
                         AND employee_passport_ID IS NOT NULL           
                         AND employee_email IS NOT NULL                  
                         AND employee_office_phone  IS NOT NULL           
                         AND employee_mobile_phone  IS NOT NULL          
                         AND employee_date_of_hire  IS NOT NULL          
                         AND employee_date_end_of_contract IS NOT NULL    
                         AND promotion_metric_amount  IS NOT NULL       
                         AND promotion_price  IS NOT NULL                 
                         AND promotion_KPI  IS NOT NULL                 
                         AND promotion_distinct_percent IS NOT NULL        
                         AND promotion_name IS NOT NULL                   
                         AND promotion_start IS NOT NULL                 
                         AND promotion_end IS NOT NULL    
                         AND gross_revenue_dollar_amount IS NOT NULL
                         AND net_revenue_dollar_amount  IS NOT NULL       
                         AND gross_cost_dollar_amount  IS NOT NULL      
                         AND net_cost_dollar_amount  IS NOT NULL         
                         AND gross_profit_dollar_amount IS NOT NULL        
                         AND net_profit_dollar_amount  IS NOT NULL        
                         AND net_salary_employee_dollar_amount IS NOT NULL  
                         AND gross_salary_employee_dollar_amount IS NOT NULL  
                         AND gross_profit_margin_percent IS NOT NULL               
                 ;
  
   BEGIN
      EXECUTE IMMEDIATE 'TRUNCATE TABLE DW_CL.cls_t_transaction';
      FOR i IN cursor_cls_transaction LOOP
         INSERT INTO DW_CL.cls_t_transaction( 
                         time_ID
                        ,customer_name
                        ,brand_name                       
                        ,customer_address                 
                        ,customer_city                    
                        ,customer_country                
                        ,customer_email                  
                        ,customer_office_phone            
                        ,customer_mobile_phone           
                        ,product_name                    
                        ,agency_name                   
                        ,agency_city                     
                        ,agency_country                  
                        ,agency_address                   
                        ,agency_postcode                 
                        ,agency_email                    
                        ,agency_office_phone             
                        ,agency_mobile_phone           
                        ,agency_Fee_percent              
                        ,agency_VAT_percent              
                        ,promotion_media_type            
                        ,category_name                   
                        ,subcategory_name                
                        ,department_name                 
                        ,employee_first_name              
                        ,employee_last_name              
                        ,employee_position               
                        ,employee_salary_project        
                        ,employee_passport_ID           
                        ,employee_email                  
                        ,employee_office_phone            
                        ,employee_mobile_phone           
                        ,employee_date_of_hire           
                        ,employee_date_end_of_contract    
                        ,promotion_metric_amount        
                        ,promotion_price                  
                        ,promotion_KPI                  
                        ,promotion_distinct_percent       
                        ,promotion_name                   
                        ,promotion_start                 
                        ,promotion_end
                        ,gross_revenue_dollar_amount 
                        ,net_revenue_dollar_amount  
                        ,gross_cost_dollar_amount       
                        ,net_cost_dollar_amount         
                        ,gross_profit_dollar_amount    
                        ,net_profit_dollar_amount       
                        ,net_salary_employee_dollar_amount
                        ,gross_salary_employee_dollar_amount 
                        ,gross_profit_margin_percent       
                        )    
              VALUES ( 
                          i.time_ID
                        , i.customer_name
                        , i.brand_name                       
                        , i.customer_address                 
                        , i.customer_city                    
                        , i.customer_country                
                        , i.customer_email                  
                        , i.customer_office_phone            
                        , i.customer_mobile_phone           
                        , i.product_name                    
                        , i.agency_name                   
                        , i.agency_city                     
                        , i.agency_country                  
                        , i.agency_address                   
                        , i.agency_postcode                 
                        , i.agency_email                    
                        , i.agency_office_phone             
                        , i.agency_mobile_phone           
                        , i.agency_Fee_percent              
                        , i.agency_VAT_percent              
                        , i.promotion_media_type            
                        , i.category_name                   
                        , i.subcategory_name                
                        , i.department_name                 
                        , i.employee_first_name              
                        , i.employee_last_name              
                        , i.employee_position               
                        , i.employee_salary_project        
                        , i.employee_passport_ID           
                        , i.employee_email                  
                        , i.employee_office_phone            
                        , i.employee_mobile_phone           
                        , i.employee_date_of_hire           
                        , i.employee_date_end_of_contract    
                        , i.promotion_metric_amount        
                        , i.promotion_price                  
                        , i.promotion_KPI                  
                        , i.promotion_distinct_percent       
                        , i.promotion_name                   
                        , i.promotion_start                 
                        , i.promotion_end
                        , i.gross_revenue_dollar_amount 
                        , i.net_revenue_dollar_amount  
                        , i.gross_cost_dollar_amount       
                        , i.net_cost_dollar_amount         
                        , i.gross_profit_dollar_amount    
                        , i.net_profit_dollar_amount       
                        , i.net_salary_employee_dollar_amount
                        , i.gross_salary_employee_dollar_amount 
                        , i.gross_profit_margin_percent  
                        );  
         EXIT WHEN cursor_cls_transaction%NOTFOUND;
      END LOOP;

      COMMIT;
   END load_cls_transaction;
END pkg_etl_cls_transaction;
--------------------------------------------------------------------------------
alter session set current_schema = DW_CL;
alter user DW_CL QUOTA UNLIMITED ON ts_dw_cl;

EXEC pkg_etl_cls_transaction.load_cls_transaction;

SELECT * FROM cls_t_transaction
order by 1;

SELECT count(*) FROM cls_t_transaction

SELECT * FROM cls_t_transaction
where promotion_name = '1515 VISA_Benefit_digital'
order by 1 ;
--------------------------------------------------------------------------------
