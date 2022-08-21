alter session set current_schema=DM_KPI;
--drop view SAL_CL.v_sal_KPI_daily;

alter session set current_schema = DW_DATA;
GRANT DELETE,INSERT,UPDATE,SELECT on DW_DATA.FCT_BUSINESS TO DM_KPI;
GRANT DELETE,INSERT,UPDATE,SELECT on DW_DATA.DIM_AGENCY TO DM_KPI;
GRANT DELETE,INSERT,UPDATE,SELECT on DW_DATA.DIM_PROMOTION TO DM_KPI;

alter session set current_schema=DM_KPI;
SELECT  * FROM SAL_CL.v_sal_KPI_daily;