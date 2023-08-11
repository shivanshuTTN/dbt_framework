{% macro customers_stg_suite(src_table,trg_table)%}


    --Suite start time
    {%set suite_time%}
        Select substr(current_timestamp,0,19)
    {%endset%}

    {% set results=run_query(suite_time)%}
    {%set results_suite_time=results.columns[0].values()%}

    {{log('Test Suite Starts At',info=true)}}
    {{log(results_suite_time[0],info=true)}}


    -- Test Case: check null value
    {{null_value(var("db_src"),var("src_schema"),var("dc_src_table"),var("db_trg"),var("trg_schema"),trg_table,var("check_column"),results_suite_time[0],'customers_stg_suite',var("list_check"))}}

    -- Test Case : Row count src vs trg
    {{row_count(var("db_src"),var("src_schema"),var("dc_src_table"),var("db_trg"),var("trg_schema"),trg_table,var("check_column"),results_suite_time[0],'customers_stg_suite',var("list_check"))}}

    -- Test Case: Column Count src vs trg
    {{column_count(var("db_src"),var("src_schema"),var("dc_src_table"),var("db_trg"),var("trg_schema"),trg_table,var("check_column"),results_suite_time[0],'customers_stg_suite',var("list_check"))}}

    -- Test Case: Duplicate Records
    {{duplicate_value(var("db_src"),var("src_schema"),var("dc_src_table"),var("db_trg"),var("trg_schema"),trg_table,var("check_column"),results_suite_time[0],'customers_stg_suite',var("list_check"))}}

    --Test Case: Not Empty
    {{not_empty(var("db_src"),var("src_schema"),var("dc_src_table"),var("db_trg"),var("trg_schema"),trg_table,var("check_column"),results_suite_time[0],'customers_stg_suite',var("list_check"))}}

    --Test Case: Top data value check of src_vs_target
    {{src_vs_trg_row_check(var("db_src"),var("src_schema"),var("dc_src_table"),var("db_trg"),var("trg_schema"),trg_table,var("check_column"),results_suite_time[0],'customers_stg_suite',var("list_check"))}}
    
    -- Checking whther any test case failed inside the suite 
    {{check_report_validation(var("db_trg"),var("trg_schema"),var("report_output_table"),var("test_case_status"),var("suite_name"),'customers_stg_suite',results_suite_time[0])}}

{%endmacro%}