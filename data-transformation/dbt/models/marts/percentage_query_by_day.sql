{{ config(materialized='table') }}

SELECT
  *,
  ROUND( SAFE_DIVIDE(CAST(sum_visitors AS NUMERIC) * 100, CAST(total_sum AS NUMERIC)), 2 ) AS prct_visitors,
  ROUND( SAFE_DIVIDE(CAST(sum_pages_viewed AS NUMERIC) * 100, CAST(total_sum AS NUMERIC)), 2 ) AS prct_pages_viewed,
  ROUND( SAFE_DIVIDE(CAST(sum_food_articles AS NUMERIC) * 100, CAST(total_sum AS NUMERIC)), 2 ) AS prct_food_articles,
  ROUND( SAFE_DIVIDE(CAST(sum_wear_articles AS NUMERIC) * 100, CAST(total_sum AS NUMERIC)), 2 ) AS prct_wear_articles,
  ROUND( SAFE_DIVIDE(CAST(sum_electronics_articles AS NUMERIC) * 100, CAST(total_sum AS NUMERIC)), 2 ) AS prct_electronics_articles,
  ROUND( SAFE_DIVIDE(CAST(sum_sports_articles AS NUMERIC) * 100, CAST(total_sum AS NUMERIC)), 2 ) AS prct_sports_articles,
  ROUND( SAFE_DIVIDE(CAST(sum_toys_articles AS NUMERIC) * 100, CAST(total_sum AS NUMERIC)), 2 ) AS prct_toys_articles,
  ROUND( SAFE_DIVIDE(CAST(sum_home_articles AS NUMERIC) * 100, CAST(total_sum AS NUMERIC)), 2 ) AS prct_home_articles,
  ROUND( SAFE_DIVIDE(CAST(sum_garden_articles AS NUMERIC) * 100, CAST(total_sum AS NUMERIC)), 2 ) AS prct_garden_articles,
  ROUND( SAFE_DIVIDE(CAST(sum_beauty_articles AS NUMERIC) * 100, CAST(total_sum AS NUMERIC)), 2 ) AS prct_beauty_articles,
  ROUND( SAFE_DIVIDE(CAST(sum_automotive_articles AS NUMERIC) * 100, CAST(total_sum AS NUMERIC)), 2 ) AS prct_automotive_articles,
  ROUND(CAST(total_sum AS NUMERIC), 2) AS total_sum_rounded
FROM {{ ref('base_data_day') }}