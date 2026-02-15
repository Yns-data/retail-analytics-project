# Création du dataset "retail_brut"
resource "google_bigquery_dataset" "retail_brut" {
  project    = var.project_id
  dataset_id = "retail_brut"
  location   = var.region
}

# Création de la table "sales"
resource "google_bigquery_table" "sales" {
  project    = var.project_id
  dataset_id = google_bigquery_dataset.retail_brut.dataset_id
  table_id   = "sales"
  schema = jsonencode([
    { name = "dates", type = "STRING", mode = "REPEATED" },
    { name = "visitors", type = "INTEGER", mode = "REPEATED" },
    { name = "pages_viewed", type = "INTEGER", mode = "REPEATED" },
    { name = "cities", type = "STRING", mode = "REPEATED" },
    { name = "food_articles", type = "FLOAT", mode = "REPEATED" },
    { name = "wear_articles", type = "FLOAT", mode = "REPEATED" },
    { name = "electronics_articles", type = "FLOAT", mode = "REPEATED" },
    { name = "books_articles", type = "FLOAT", mode = "REPEATED" },
    { name = "sports_articles", type = "FLOAT", mode = "REPEATED" },
    { name = "toys_articles", type = "FLOAT", mode = "REPEATED" },
    { name = "home_articles", type = "FLOAT", mode = "REPEATED" },
    { name = "garden_articles", type = "FLOAT", mode = "REPEATED" },
    { name = "beauty_articles", type = "FLOAT", mode = "REPEATED" },
    { name = "automotive_articles", type = "FLOAT", mode = "REPEATED" }
  ])
}

# Création du dataset "retail_stage"
resource "google_bigquery_dataset" "retail_staging" {
  project    = var.project_id
  dataset_id = "retail_staging"
  location   = var.region
}

# Création de la table "sales" dans staging
resource "google_bigquery_table" "sales_staging" {
  project    = var.project_id
  dataset_id = google_bigquery_dataset.retail_staging.dataset_id
  table_id   = "sales_staging"
  deletion_protection = false
  schema = jsonencode([
    { name = "dates", type = "STRING"},
    { name = "visitors", type = "INTEGER" },
    { name = "pages_viewed", type = "INTEGER"},
    { name = "cities", type = "STRING"},
    { name = "food_articles", type = "FLOAT"},
    { name = "wear_articles", type = "FLOAT"},
    { name = "electronics_articles", type = "FLOAT"},
    { name = "books_articles", type = "FLOAT"},
    { name = "sports_articles", type = "FLOAT"},
    { name = "toys_articles", type = "FLOAT"},
    { name = "home_articles", type = "FLOAT"},
    { name = "garden_articles", type = "FLOAT"},
    { name = "beauty_articles", type = "FLOAT"},
    { name = "automotive_articles", type = "FLOAT"}
  ])
}

# Création de la table "sales" dans staging
resource "google_bigquery_table" "sales_date_decomposed" {
  project    = var.project_id
  dataset_id = google_bigquery_dataset.retail_staging.dataset_id
  table_id   = "sales_dates_decomposed"
  schema = jsonencode([
    { name = "year", type = "INTEGER"},
    { name = "month", type = "STRING" },
    { name = "day", type = "STRING"},
    { name = "hour", type = "INTEGER"},
    { name = "visitors", type = "INTEGER" },
    { name = "pages_viewed", type = "INTEGER"},
    { name = "cities", type = "STRING"},
    { name = "food_articles", type = "FLOAT"},
    { name = "wear_articles", type = "FLOAT"},
    { name = "electronics_articles", type = "FLOAT"},
    { name = "books_articles", type = "FLOAT"},
    { name = "sports_articles", type = "FLOAT"},
    { name = "toys_articles", type = "FLOAT"},
    { name = "home_articles", type = "FLOAT"},
    { name = "garden_articles", type = "FLOAT"},
    { name = "beauty_articles", type = "FLOAT"},
    { name = "automotive_articles", type = "FLOAT"}
  ])
}