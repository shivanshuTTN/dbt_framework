{% macro duplicate_value(src_database_name,src_schema_name,src_table_name,trg_database_name,trg_schema_name,trg_table_name,column_name,suite_start_time,suite_id,column_list)%}


    {{log('duplicate value test case execution started',info=true)}}

    -- Calculating the time of execution of the curret test
    {%set test_case_time%}
        Select substr(current_timestamp,0,19)
    {%endset%}

    {% set results=run_query(test_case_time)%}
    {%set results_testcase_time=results.columns[0].values()%}
    {{log('testcase execution start time',info=true)}}
    {{log(results_testcase_time[0],info=true)}}


    --For loop used to iterate in every column
    {%for column_value in column_list %}
        {%set query%}
            Select  
            case  when cnt=0 then 'pass' else 'fail' end from
            (Select count({{column_value}}) as cnt  from 
            (Select {{column_value}} from {{trg_database_name}}.{{trg_schema_name}}.{{trg_table_name}}
            group by ({{column_value}}) having count({{column_value}})>1))
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
        {{insert_macro(query_id_result[0],suite_start_time,results_testcase_time[0],suite_id,'duplicate_value','generic', src_database_name,
        src_schema_name,src_table_name,trg_database_name,trg_schema_name,trg_table_name,column_value,results_list[0])}}

    {%  endfor %}
    
    {{log('duplicate value test case execution started',info=true)}}
{%endmacro%}