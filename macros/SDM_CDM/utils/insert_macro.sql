{% macro insert_macro(QUERY_ID,SUITE_START_AT,EXECUTION_DATETIME,SUITE_ID,TEST_CASE_ID,
TEST_CASE_TYPE,SRC_DB_NAME,SRC_SCHEMA_NAME,SRC_TABLE_NAME,TRG_DB_NAME,
TRG_SCHEMA_NAME,TRG_TABLE_NAME,TRG_COLUMN,TEST_CASE_STATUS)%}


{{log('Inserting',info=true)}}
    {%set query%}

        {{log('Inserting2',info=true)}}
        insert into {{ref('test_output_table')}} 
        values('{{QUERY_ID}}','{{SUITE_START_AT}}','{{EXECUTION_DATETIME}}',
        '{{SUITE_ID}}','{{TEST_CASE_ID}}','{{TEST_CASE_TYPE}}','{{SRC_DB_NAME}}',
        '{{SRC_SCHEMA_NAME}}','{{SRC_TABLE_NAME}}','{{TRG_DB_NAME}}','{{TRG_SCHEMA_NAME}}',
        '{{TRG_TABLE_NAME}}','{{TRG_COLUMN}}','{{TEST_CASE_STATUS}}')

        {{log('Inserting3',info=true)}}
        
    {% endset %}

    {% do run_query(query)%}
{% endmacro%}