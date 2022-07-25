select * from SYS.dba_tablespaces;
select * from all_tables;

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

select * from u_dw_ext_references.t_ext_languages_iso693;
select * from u_dw_references.w_lng_links;
select * from U_DW_REFERENCES.cu_lng_scopes;
select * from U_DW_REFERENCES.cu_lng_types;
select * from U_DW_REFERENCES.cu_languages;