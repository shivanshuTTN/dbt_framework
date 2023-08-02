{{config(materialized='incremental')}}



with t1 as
(
    Select * from test_output_table
    {% if is_incremental() %}
    where EXECUTION_DATETIME>=(select max(EXECUTION_DATETIME) from {{this}})
    {% endif %}
    
)
Select * from t1