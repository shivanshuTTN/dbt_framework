{% macro orders_stg_suite(trg_table)%}

     --Suite start time
    {%set suite_time%}
        Select substr(current_timestamp,0,19)
    {%endset%}

    {% set results=run_query(suite_time)%}
    {%set results_suite_time=results.columns[0].values()%}

    {{log('Test Suite Starts At',info=true)}}
    {{log(results_suite_time[0],info=true)}}

    {{log(trg_table,info=true)}}
    

    -- Test Case : Null value check
    {{null_value(var("db_src"),var("src_schema"),var("dc_src_table_orders"),var("db_trg"),var("trg_schema"),trg_table,var("check_column"),results_suite_time[0],'customer_stg_suite',var("list_check_orders"))}}

    -- Test Case : Row count src vs trg
    {{row_count(var("db_src"),var("src_schema"),var("dc_src_table_orders"),var("db_trg"),var("trg_schema"),trg_table,var("check_column"),results_suite_time[0],'orders_stg_suite',var("list_check_orders"))}}

    -- Test Case: Column Count src vs trg
    {{column_count(var("db_src"),var("src_schema"),var("dc_src_table_orders"),var("db_trg"),var("trg_schema"),trg_table,var("check_column"),results_suite_time[0],'orders_stg_suite',var("list_check_orders"))}}

    -- Test Case: Duplicate Records
    {{duplicate_value(var("db_src"),var("src_schema"),var("dc_src_table_orders"),var("db_trg"),var("trg_schema"),trg_table,var("check_column"),results_suite_time[0],'orders_stg_suite',var("list_check_orders"))}}

    --Test Case: Not Empty
     {{not_empty(var("db_src"),var("src_schema"),var("dc_src_table_orders"),var("db_trg"),var("trg_schema"),trg_table,var("check_column"),results_suite_time[0],'orders_stg_suite',var("list_check_orders"))}}

    --Test Case:  date_format_YYYY_MON_DD
    {{date_format_YYYY_MM_DD(var("db_src"),var("src_schema"),var("dc_src_table_orders"),var("db_trg"),var("trg_schema"),trg_table,var("check_date_format_column"),results_suite_time[0],'orders_stg_suite')}}

    --Test Case: Top data  value check
    {{src_vs_trg_row_check(var("db_src"),var("src_schema"),var("dc_src_table_orders"),var("db_trg"),var("trg_schema"),trg_table,var("check_column"),results_suite_time[0],'orders_stg_suite',var("list_check_orders"))}}

    -- Checking whther any test case failed inside the suite 
    {{check_report_validation(var("db_trg"),var("trg_schema"),var("report_output_table"),var("test_case_status"),var("suite_name"),'orders_stg_suite',results_suite_time[0])}}

{% endmacro %}