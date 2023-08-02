{{config(materialized='table')}}

Select 
cust.id as customer_id,
cust.first_name as first_name,
cust.last_name as last_name,
ord.id as order_id,
ord.order_date as order_date,
ord.status order_status,
ord._etl_loaded_at as _etl_loaded_at
from {{var('db_src')}}.{{var('src_schema')}}.{{var('dc_src_table')}} as cust
inner join
{{var('db_src')}}.{{var('src_schema')}}.{{var('dc_src_table_orders')}} as ord
on cust.{{var('foreign_key_column_cust')}}=ord.{{var('foreign_key_column_order')}}
where order_status='{{var('o_status')}}'