{% macro column_count(src_database_name,src_schema_name,src_table_name,trg_database_name,trg_schema_name,trg_table_name,column_name,suite_start_time,suite_id,column_list)%}

    {{log('column value test case execution started',info=true)}}

    -- Calculating the time of execution of the curret test
    {%set test_case_time%}
        Select substr(current_timestamp,0,19)
    {%endset%}

    {% set results=run_query(test_case_time)%}
    {%set results_testcase_time=results.columns[0].values()%}

    {{log('testcase execution start time',info=true)}}
    {{log(results_testcase_time[0],info=true)}}


    {%set query%}
    
        Select 
        case when src_column_count=trg_column_count then 'PASS' else 'FAIL' end as status from
        (select count(*) as src_column_count from {{src_database_name}}.INFORMATION_SCHEMA.columns
        where table_name='{{src_table_name}}') as src_tb,
        (select count(*) as trg_column_count from {{trg_database_name}}.INFORMATION_SCHEMA.columns 
        where table_name='{{trg_table_name}}') as trg_tb
        
    {%endset%}

    {% set results=run_query(query)%}
    {%set results_list=results.columns[0].values()%}
    {{log(results_list[0],info='True')}}

    -- Calculating the query ID
    {%set query_id%}
        Select last_query_id();
    {%endset%}

    {% set results=run_query(query_id)%}
    {%set query_id_result=results.columns[0].values()%}
        

   
    -- Insert macro called to insert in test report
    
    {{insert_macro(query_id_result[0],suite_start_time,results_testcase_time[0],suite_id,'column_count','src vs landing', src_database_name,
    src_schema_name,src_table_name,trg_database_name,trg_schema_name,trg_table_name,'none',results_list[0])}}
    {{log('column value test case execution ended',info=true)}}
 
{% endmacro %}