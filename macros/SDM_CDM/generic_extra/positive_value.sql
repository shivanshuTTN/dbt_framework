{% macro positive_value()%}

    {%set query%}
        

        Select 
        case when positive_count=0 then 'pass' else 'fail' end
         from (Select count(*) as positive_count 
        from {{source('trg_jaffle_shop','customers_stg')}} 
        where {{var('check_column')}}<0)
    {%endset%}

    {%  set results=run_query(query)%}
    {% if execute%}
    {%set results_list=results.columns[0].values()%}
    {% else %}
    {% set results_lists = [] %}
    
    {% endif %}

{{log(results_list[0],info='True')}}


{%endmacro%}