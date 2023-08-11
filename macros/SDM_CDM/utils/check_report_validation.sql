{%  macro check_report_validation(trg_database_name,trg_schema_name,output_table,column_name,suite_output_id,suite_name,suite_timestamp)%}


    {{log('check report execution',info=true)}}


    --counting how many test cases fail 
    {%set fail_count_query%}
        
        Select count(*) as fail_count 
        from {{trg_database_name}}.{{trg_schema_name}}.{{output_table}}
        where {{column_name}}='FAIL' and {{suite_output_id}}='{{suite_name}}'
        and {{var('suite_start_time')}}='{{suite_timestamp}}'
        
    {%  endset %}

    {%set results=run_query(fail_count_query)%}
    {% set results_lists = results.columns[0].values() %}
    {{log(results_lists[0],info='True')}}

    --if there are test cases which are failing then raising an error
    {%if results_lists[0]>0 %}
         {{ exceptions.raise_compiler_error("Test case Failed. Got: " ~results_lists[0]) }}
    {%endif%}

{%endmacro%}