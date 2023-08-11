{% macro src_vs_trg_row_check(src_database_name,src_schema_name,src_table_name,trg_database_name,trg_schema_name,trg_table_name,column_name,suite_start_time,suite_id,column_list)%}

    {{log('src_vs_trg_row_check  test case execution started',info=true)}}

    -- Calculating the time of execution of the curret test
    {%set test_case_time%}
        Select substr(current_timestamp,0,19)
    {%endset%}

    {% set results=run_query(test_case_time)%}
    {%set results_testcase_time=results.columns[0].values()%}

    
    {% for col_name in cust_columns %}
   
            {{log(col_name,info=true)}}
            {% set query%}
            
                Select 
                case when src =trg then 'PASS' else 'FAIL' end as status from
                (Select {{col_name}} as src from {{src_database_name}}.{{src_schema_name}}.{{src_table_name}}
                order by {{col_name}} limit 1) as src_tb,
                (Select {{col_name}}   as trg from {{trg_database_name}}.{{trg_schema_name}}.{{trg_table_name}}
                order by {{col_name}}  limit 1) as trg_tb
            
            {% endset %}
            
            {% set results = run_query(query) %}
            {% set results_lists = results.columns[0].values() %}
            {{log(results_lists[0],info='True')}}

             --Getting ID for the query
            {%set query_id%}
                    Select last_query_id();
            {%endset%}

            {% set results=run_query(query_id)%}
            {%set query_id_result=results.columns[0].values()%}
                

            -- Insert macro called to insert in test report
           {{insert_macro(query_id_result[0],suite_start_time,results_testcase_time[0],suite_id,'src_vs_trg','landing vs dim', src_database_name,
            src_schema_name,src_table_name,trg_database_name,trg_schema_name,trg_table_name,col_name,results_lists[0])}} 
        
        
    {% endfor%}


        {{log('src_vs_trg_row_check test case execution ended',info=true)}}
    
    


{% endmacro %}