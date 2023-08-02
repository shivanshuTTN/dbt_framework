{% macro check_datatype()%}

    {% set query1%}
    
             Select DATA_TYPE from  {{source('jaffle_shop','customers')}}.INFORMATION_SCHEMA.COLUMNS  where 
              TABLE_NAME='{{var('dc_src_table')}}' and COLUMN_NAME='{{var('check_column')}}'

   
    {% endset %}

    
    {% set query2%}
    
             Select DATA_TYPE from {{var('db_trg')}}.INFORMATION_SCHEMA.COLUMNS  where 
              TABLE_NAME='{{var('dc_trg_table')}}' and COLUMN_NAME='{{var('check_column')}}'

   
    {% endset %}


    {%set results1 =dbt_utils.get_single_value(query1) %}
    {%set results2 =dbt_utils.get_single_value(query2) %}

    {% if results1==results2%}
        {{log('pass',info='True')}}
    {% else %}
        {{log('fail',info='True')}}
    {%endif  %}
    
{% endmacro %}