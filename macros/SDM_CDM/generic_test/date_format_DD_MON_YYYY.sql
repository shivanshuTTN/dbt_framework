{% macro date_format_DD_MON_YYYY(src_database_name,src_schema_name,src_table_name,trg_database_name,trg_schema_name,trg_table_name,column_name,suite_start_time,suite_id)%}

    {{log('date_format_DD_MON_YYYY test execution started ',info=true)}}
    {%set query%}
          Select 
          case when cnt=0 then 'pass' else 'fail' end 
          from
          (Select count(*) as cnt from (
          Select try_to_date(substr({{column_name}},0,10),'DD-MON-YYYY') as new_date 
          from {{trg_database_name}}.{{trg_schema_name}}.{{trg_table_name}}) 
          where new_date is null)

    {%endset%}

    {% set date_format_result=run_query(query)%}
    {% set date_format_list=date_format_result.columns[0].values()%}

    {{log(date_format_list[0],info=true)}}

    {{log('date_format_DD_MON_YYYY test execution ended ',info=true)}}

{% endmacro %}