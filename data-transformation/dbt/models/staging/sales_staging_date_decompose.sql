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


SELECT
  EXTRACT(YEAR FROM time_stamp) AS year,
  FORMAT_TIMESTAMP('%B', time_stamp) AS month,
  FORMAT_TIMESTAMP('%A', time_stamp) AS day,
  EXTRACT(HOUR FROM time_stamp) AS hour,
  EXTRACT(MINUTE FROM time_stamp) AS minutes,
  *


FROM {{ ref('sales_staging') }}

{% if is_incremental() %}
where time_stamp > (
  select max(parse_timestamp('%Y-%m-%d-%H-%M-%S', dates)) from {{ this }}
)
{% endif %}