{{config(materialized='table')}}




Select * 
from {{var('db_src')}}.{{var('src_schema')}}.{{var('dc_src_table_orders')}}