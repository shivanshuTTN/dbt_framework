{{config(
    materialized='table',
    pre_hook='CREATE TABLE IF NOT EXISTS raw_stg.cdm.TEST_OUTPUT_TABLE
            (QUERY_ID VARCHAR(300), 
            SUITE_START_AT VARCHAR(300),
            EXECUTION_DATETIME VARCHAR(300),
            SUITE_ID VARCHAR(300),
            TEST_CASE_ID VARCHAR(300),
            TEST_CASE_TYPE VARCHAR(300),
            SRC_DB_NAME VARCHAR(300),
            SRC_SCHEMA_NAME VARCHAR(300),
            SRC_TABLE_NAME VARCHAR(300),
            TRG_DB_NAME VARCHAR(300),
            TRG_SCHEMA_NAME VARCHAR(300),
            TRG_TABLE_NAME VARCHAR(300),
            TRG_COLUMN VARCHAR(300),
            TEST_CASE_STATUS VARCHAR(5)
            )'
             )}}



    Select * from  TEST_OUTPUT_TABLE