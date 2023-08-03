{% macro top1_value_check(src_database_name,src_schema_name,src_table_name,trg_database_name,trg_schema_name,trg_table_name,column_name,suite_start_time,suite_id,column_list,src_joined_table)%}

    {{log('top1_value_check test case execution started',info=true)}}

    -- Calculating the time of execution of the curret test
    {%set test_case_time%}
        Select substr(current_timestamp,0,19)
    {%endset%}

    {% set results=run_query(test_case_time)%}
    {%set results_testcase_time=results.columns[0].values()%}

    {% set query%}
    
        Select 
        case when src_tb.{{column_name}}=trg_tb.{{column_name}} then 'pass' else 'fail' end as status from
        (Select {{column_name}} from {{src_database_name}}.{{src_schema_name}}.{{src_table_name}}
        order by {{column_name}} limit 1) as src_tb,
        (Select {{column_name}} from {{trg_database_name}}.{{trg_schema_name}}.{{trg_table_name}}
        order by {{column_name}}   limit 1) as trg_tb

    
    {% endset %}
    
    {% set results = run_query(query) %}
    {% set results_lists = results.columns[0].values() %}
    {{log(results_lists[0],info='True')}}

    {%set query_id%}
            Select last_query_id();
    {%endset%}

    {% set results=run_query(query_id)%}
    {%set query_id_result=results.columns[0].values()%}
        

    -- Insert macro called to insert in test report
    {{insert_macro(query_id_result[0],suite_start_time,results_testcase_time[0],suite_id,'top1_value_check','generic', src_database_name,
    src_schema_name,src_table_name,trg_database_name,trg_schema_name,trg_table_name,'none',results_lists[0])}}


    {{log('top1_value_check test case execution ended',info=true)}}


{% endmacro %}