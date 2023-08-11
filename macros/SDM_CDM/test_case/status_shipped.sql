{% macro status_shipped(src_database_name,src_schema_name,src_table_name_1,src_table_name_2,
trg_database_name,trg_schema_name,trg_table_name,suite_start_time,
suite_id,column_base,refrence_column_name,column_to_check,column_condition,src1_src2_table) %}



    {{log('shipped_status test case execution started',info=true)}}
    

    -- Calculating the time of execution of the curret test
    {%set test_case_time%}
        Select substr(current_timestamp,0,19)
    {%endset%}

    {% set results=run_query(test_case_time)%}
    {%set results_testcase_time=results.columns[0].values()%}

    /* Here we are joining table on the basis of a common attribute and then taking data based on certain condition
    like */
    {%set query%}
        Select 
        case when src_customer_id=trg_customer_id then 'PASS' else 'FAIL' end
        from
        (Select 
        {{src_table_name_1}}.{{column_base}} as src_customer_id
        from {{src_database_name}}.{{src_schema_name}}.{{src_table_name_1}} 
        inner join
        {{src_database_name}}.{{src_schema_name}}.{{src_table_name_2}}
        on {{src_table_name_1}}.{{column_base}}={{src_table_name_2}}.{{refrence_column_name}} 
        where {{column_to_check}}='{{column_condition}}' limit 1) as src,
        (Select  customer_id as trg_customer_id from {{trg_database_name}}.{{trg_schema_name}}.{{trg_table_name}} limit 1) as trg
    {% endset %}

    {%set results = run_query(query)%}
    {%set results_list=results.columns[0].values()%}
    {{log(results_list[0],info=true)}}
    

    -- --Getting ID for the query
    {%set query_id%}
        Select last_query_id();
    {%endset%}

    {% set results=run_query(query_id)%}
    {%set query_id_result=results.columns[0].values()%}
        
    -- Insert macro called to insert in test report
    {{insert_macro(query_id_result[0],suite_start_time,results_testcase_time[0],suite_id,'status_shipped','test_case_specific', src_database_name,
    src_schema_name,src1_src2_table,trg_database_name,trg_schema_name,trg_table_name,column_to_check,results_list[0])}}


    {{log('shipped_status test case execution ended',info=true)}}


{% endmacro %}