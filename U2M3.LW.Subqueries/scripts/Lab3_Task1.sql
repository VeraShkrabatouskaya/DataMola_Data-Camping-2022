--DROP TABLESPACE ts_geo_denormalized INCLUDING CONTENTS AND DATAFILES CASCADE CONSTRAINTS;
--DROP USER SB_MBackUp;
--SELECT * from dba_data_files;
ALTER SYSTEM SET db_create_file_dest = '/oracle/u02/oradata/VShkrabatovskayadb';

CREATE TABLESPACE ts_geo_denormalized
DATAFILE '/oracle/u02/oradata/VShkrabatovskayadb/db_ts_geo_denormalized.dat'
SIZE 150M
AUTOEXTEND ON NEXT 50M
SEGMENT SPACE MANAGEMENT AUTO;

CREATE USER SB_MBackUp 
IDENTIFIED BY "%PWD%"
DEFAULT TABLESPACE ts_geo_denormalized;

GRANT CONNECT,RESOURCE TO SB_MBackUp;
GRANT SELECT ANY TABLE TO SB_MBackUp;

ALTER USER SB_MBackUp QUOTA UNLIMITED ON ts_geo_denormalized;

--------------------------------------------------------------------------------
alter session set current_schema=u_dw_references;

select * from t_cntr_group_systems, lc_cntr_group_systems, t_cntr_groups, lc_cntr_groups, t_cntr_sub_groups,
              lc_cntr_sub_groups, t_countries, lc_countries, t_geo_object_links, t_geo_objects, t_geo_parts, lc_geo_parts, t_geo_regions,
              lc_geo_regions, t_geo_systems, lc_geo_systems, t_geo_types;
              
alter session set current_schema=u_dw_references;
select * from t_geo_object_links;
            
-------------------------------------------------------------------------------
--DROP table data_geo;
create table data_geo AS 
SELECT 
    tgo.geo_id, tgo.geo_type_id, tgo.geo_code_id,
    tgt.geo_type_code, tgt.geo_type_desc,
    lcgs.grp_system_id, lcgs.grp_system_code, lcgs.grp_system_desc, lcgs.localization_id,
    lcg.group_id, lcg.group_code, lcg.group_desc,
    lcsg.sub_group_id, lcsg.sub_group_code, lcsg.sub_group_desc,
    lc.country_id, lc.country_code_a2, lc.country_code_a3, lc.country_desc,
    lgr.region_id, lgr.region_code, lgr.region_desc,
    lgp.part_id, lgp.part_code, lgp.part_desc,
    lgs.geo_system_id, lgs.geo_system_code, lgs.geo_system_desc,
    tgol.parent_geo_id, tgol.child_geo_id, tgol.link_type_id                  
from 
    t_geo_objects tgo
    LEFT OUTER JOIN t_geo_types tgt ON tgo.geo_type_id = tgt.geo_type_id
    LEFT OUTER JOIN t_geo_object_links tgol ON tgo.geo_id = tgol.parent_geo_id
    LEFT OUTER JOIN lc_cntr_group_systems lcgs ON tgo.geo_id = lcgs.geo_id
    LEFT OUTER JOIN lc_cntr_groups lcg ON tgo.geo_id = lcg.geo_id
    LEFT OUTER JOIN lc_cntr_sub_groups lcsg ON tgo.geo_id = lcsg.geo_id 
    LEFT OUTER JOIN lc_countries lc ON tgo.geo_id = lc.geo_id
    LEFT OUTER JOIN lc_geo_regions lgr ON tgo.geo_id = lgr.geo_id
    LEFT OUTER JOIN lc_geo_parts lgp ON tgo.geo_id = lgp.geo_id
    LEFT OUTER JOIN lc_geo_systems lgs ON tgo.geo_id = lgs.geo_id;    
    
    select * from data_geo;

SELECT
    geo_id, geo_type_id, geo_code_id,
    geo_type_code, geo_type_desc,
    parent_geo_id, child_geo_id, link_type_id
FROM
    data_geo;

drop table geo_denormalized_t;

create table geo_denormalized_t AS 
SELECT
    LPAD(' ', 4 * lvl, ' ') || geo_object.geo_id AS geo_id,
    parent_geo_id,
    DECODE(( SELECT COUNT(*)
             FROM t_geo_object_links tgol
             WHERE tgol.parent_geo_id = geo_object.geo_id),
                0,
                NULL,
                (SELECT COUNT(*)
                FROM t_geo_object_links tgol
                WHERE tgol.parent_geo_id = geo_object.geo_id
                )) AS child_amount,
    lvl,
    id_type,
    PATH                 
FROM (
    SELECT geo_id,
           parent_geo_id,
           LEVEL AS lvl,
           DECODE(LEVEL, 1, 'ROOT', 2, 'BRANCH_1', 3, 'BRANCH_2', 4, 'LEAF') AS id_type,
           SYS_CONNECT_BY_PATH(geo_id, '-->') AS path,
           REGEXP_SUBSTR(SYS_CONNECT_BY_PATH(geo_id, '-->'), '-->', 1, 1, NULL, 1) AS Level1,
           REGEXP_SUBSTR(SYS_CONNECT_BY_PATH(geo_id, '-->'), '-->', 1, 2, NULL, 1) AS Level2,
           REGEXP_SUBSTR(SYS_CONNECT_BY_PATH(geo_id, '-->'), '-->', 1, 3, NULL, 1) AS Level3,
           REGEXP_SUBSTR(SYS_CONNECT_BY_PATH(geo_id, '-->'), '-->', 1, 4, NULL, 1) AS Level4
    FROM (
          SELECT *
          FROM t_geo_objects
          LEFT OUTER JOIN t_geo_object_links ON child_geo_id = geo_id
         )
    START WITH parent_geo_id IS NULL
    CONNECT BY PRIOR geo_id = parent_geo_id
    ORDER SIBLINGS BY geo_id
     )  geo_object;
        
SELECT * FROM geo_denormalized_t;




          
          
          
          
          
          


