{% macro customer_order_vs_trg(trg_table,column_base,column_foreign,column_to_checked,column_condition)%}

    
     --Suite start time
    {%set suite_time%}
        Select substr(current_timestamp,0,19)
    {%endset%}

    {% set results=run_query(suite_time)%}
    {%set results_suite_time=results.columns[0].values()%}

    {{log('Test Suite Starts At',info=true)}}
    {{log(results_suite_time[0],info=true)}}

    {{log(trg_table,info=true)}}
    
    
    
    -- Test Case: check null value
    {{null_value(var("db_src"),var("src_schema"),var("src1_src2_table"),var("db_trg"),var("trg_schema"),trg_table,var("check_status_column"),results_suite_time[0],'customer_order_vs_trg',var("list_status_shipped"))}}


    -- Test Case: Duplicate Records
    {{duplicate_value(var("db_src"),var("src_schema"),var("src1_src2_table"),var("db_trg"),var("trg_schema"),trg_table,var("check_status_column"),results_suite_time[0],'customer_order_vs_trg',var("list_status_shipped"))}}

    --Test Case: Not Empty
    {{not_empty(var("db_src"),var("src_schema"),var("src1_src2_table"),var("db_trg"),var("trg_schema"),trg_table,var("check_status_column"),results_suite_time[0],'customer_order_vs_trg',var("list_status_shipped"))}}

    
    -- Test Case : joined table to check shipping status as shipped
    {{status_shipped(var("db_src"),var("src_schema"),var("dc_src_table"),var("dc_src_table_orders"),var("db_trg"),var("trg_schema"),trg_table,results_suite_time[0],'customer_order_vs_trg',column_base,column_foreign,column_to_checked,column_condition,var("src1_src2_table"))}}
    
    -- Checking whther any test case failed inside the suite 
    {{check_report_validation(var("db_trg"),var("trg_schema"),var("report_output_table"),var("test_case_status"),var("suite_name"),'customer_order_vs_trg',results_suite_time[0])}}


   

  
{%endmacro%}