{{ config(
    materialized='incremental',
    incremental_strategy='merge',
    unique_key='dates',
    partition_by={
      "field": "time_stamp",
      "data_type": "timestamp",
      "granularity": "day",
    }
) }}

{% set rel = source('raw_data', env_var('BQ_TABLE_NAME')) %}

with src as (
  select
    {{ select_first_elem_for_arrays(rel, exclude=['_ingestion_ts']) }}
  from {{ rel }}
),
src_1 as (
  select
    *,
    SAFE.PARSE_TIMESTAMP('%Y-%m-%d-%H-%M-%S', dates) as time_stamp
  from src
)

select
  *
from src_1

{% if is_incremental() %}
where time_stamp > (
  select max(time_stamp) from {{ this }}
)
{% endif %}