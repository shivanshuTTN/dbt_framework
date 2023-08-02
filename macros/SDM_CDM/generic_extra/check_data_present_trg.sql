{% macro check_data_present_trg()%}

    {%set query%}
            Select 
            case when  count(*)<>0 then 'pass' else 'fail' end
            from {{source('trg_jaffle_shop','customers_stg')}}
    {%endset%}

    {% set results=run_query(query)%}
        {% if execute%}
        {%set results_list=results.columns[0].values()%}

        {% else %}
        {% set results_lists = [] %}
        
        {% endif %}

    {{log(results_list[0],info='True')}}

{% endmacro %}