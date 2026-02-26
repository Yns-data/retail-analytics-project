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

