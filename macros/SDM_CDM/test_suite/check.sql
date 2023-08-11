{% macro check(trg_table)%}

    
     --Suite start time
    {%set suite_time%}
        Select substr(current_timestamp,0,19)
    {%endset%}

    {% set results=run_query(suite_time)%}
    {%set results_suite_time=results.columns[0].values()%}

    {{log('Test Suite Starts At',info=true)}}
    {{log(results_suite_time[0],info=true)}}

    {{log(trg_table,info=true)}}
    
   
    {{src_vs_trg(var("db_src"),var("src_schema"),var("dc_src_table_orders"),var("db_trg"),var("trg_schema"),trg_table,var("check_column"),results_suite_time[0],'check_suite',list_check_orders)}}

    /*{{check_report_validation(var("db_trg"),var("trg_schema"),var("report_output_table"),var("test_case_status"),var("suite_name"),'check',results_suite_time[0])}}*/

{%endmacro%}


