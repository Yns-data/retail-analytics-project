{{ config(
    materialized='sales_staging',        
    schema='retail_staging'      
) }}

SELECT 
dates[SAFE_OFFSET(0)] as dates,
visitors[SAFE_OFFSET(0)] as visitors,
pages_viewed[SAFE_OFFSET(0)] as pages_viewed,
cities[SAFE_OFFSET(0)] as cities,
food_articles[SAFE_OFFSET(0)] as food_articles,
wear_articles[SAFE_OFFSET(0)] as wear_articles,
electronics_articles[SAFE_OFFSET(0)] as electronics_articles,
books_articles[SAFE_OFFSET(0)] as books_articles,
toys_articles[SAFE_OFFSET(0)] as toys_articles,
home_articles[SAFE_OFFSET(0)] as home_articles,
garden_articles[SAFE_OFFSET(0)] as garden_articles,
beauty_articles[SAFE_OFFSET(0)] as beauty_articles,
automotive_articles[SAFE_OFFSET(0)] as automotive_articles,
FROM 