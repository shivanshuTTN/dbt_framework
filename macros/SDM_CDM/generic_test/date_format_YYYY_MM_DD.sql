{% macro date_format_YYYY_MM_DD(src_database_name,src_schema_name,src_table_name,trg_database_name,trg_schema_name,trg_table_name,column_name,suite_start_time,suite_id)%}

    {{log('date_format_YYYY_MM_DD test execution started ',info=true)}}

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
        case when cnt=0 then 'pass' else 'fail' end 
        from
        (Select count(*) as cnt from 
        (Select try_to_date(substr({{column_name}},0,10),'YYYY-MM-DD') as new_date 
        from {{trg_database_name}}.{{trg_schema_name}}.{{trg_table_name}})
        where new_date is null)

    {%endset%}

    {% set date_format_result=run_query(query)%}
    {% set date_format_list=date_format_result.columns[0].values()%}

    {{log(date_format_list[0],info=true)}}

    -- Calculating the query ID
    {%set query_id%}
        Select last_query_id();
    {%endset%}

    {% set results=run_query(query_id)%}
    {%set query_id_result=results.columns[0].values()%}
        
    -- Insert macro called to insert in test report
    {{insert_macro(query_id_result[0],suite_start_time,results_testcase_time[0],suite_id,'date_format_YYYY_MM_DD','generic', src_database_name,
    src_schema_name,src_table_name,trg_database_name,trg_schema_name,trg_table_name,column_name,date_format_list[0])}}


    {{log('date_format_YYYY_MM_DD test execution ended ',info=true)}}

{% endmacro %}