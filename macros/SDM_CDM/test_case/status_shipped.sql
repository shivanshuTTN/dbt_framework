
{% macro status_shipped(src_database_name,src_schema_name,src_table_name,trg_database_name,trg_schema_name,trg_table_name,column_name,suite_start_time,suite_id,column_list) %}

    {%set query%}
        Select 
        case when src_customer_id=trg_customer_id then 'pass' else 'fail' end
        from
        (Select 
        cust.id as src_customer_id
        from {{src_database_name}}.{{src_schema_name}}.{{var('dc_src_table')}} as cust
        inner join
        {{src_database_name}}.{{src_schema_name}}.{{var('dc_src_table_orders')}} as ord
        on cust.{{var('foreign_key_column_cust')}}=ord.{{var('foreign_key_column_order')}} 
        where status='{{var("o_status")}}' limit 1) as src,
        (Select  customer_id as trg_customer_id from {{trg_database_name}}.{{trg_schema_name}}.{{trg_table_name}} limit 1) as trg
    {% endset %}

    {%set results = run_query(query)%}
    {%set results_list=results.columns[0].values()%}
    {{log(results_list[0],info=true)}}


{% endmacro %}