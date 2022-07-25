alter session set current_schema=u_dw_references;

select * from all_objects where owner = UPPER('U_DW_EXT_REFERENCES')
order by OBJECT_TYPE, OBJECT_NAME;

select * from all_objects where owner = UPPER('U_DW_REFERENCES')
order by OBJECT_TYPE, OBJECT_NAME;

select * from all_objects where owner = UPPER('U_DW_COMMON')
order by OBJECT_TYPE, OBJECT_NAME;

SELECT TABLE_NAME, OWNER
FROM SYS.ALL_TABLES
WHERE OWNER IN ('U_DW_EXT_REFERENCES', 'U_DW_REFERENCES', 'U_DW_COMMON')
UNION ALL
SELECT VIEW_NAME, OWNER
FROM SYS.ALL_VIEWS
WHERE OWNER IN ('U_DW_EXT_REFERENCES', 'U_DW_REFERENCES', 'U_DW_COMMON')
ORDER BY 2;

select * from t_addresses;
select * from t_address_types;

select * from t_cntr_group_systems;
select * from lc_cntr_group_systems;

select * from t_cntr_groups;
select * from lc_cntr_groups;

select * from t_cntr_sub_groups;
select * from lc_cntr_sub_groups;

select * from t_countries;
select * from lc_countries;

select * from t_geo_object_links;

select * from t_geo_objects;

select * from t_geo_parts;
select * from lc_geo_parts;

select * from t_geo_regions;
select * from lc_geo_regions;

select * from t_geo_systems;
select * from lc_geo_systems;

select * from t_geo_types;
