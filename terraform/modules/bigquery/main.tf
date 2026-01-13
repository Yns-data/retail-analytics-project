# Création du dataset "retail"
resource "google_bigquery_dataset" "retail" {
  project    = var.project_id
  dataset_id = "retail"
  location   = var.region
}

# Création de la table "sales"
resource "google_bigquery_table" "sales" {
  project    = var.project_id
  dataset_id = google_bigquery_dataset.retail.dataset_id
  table_id   = "sales"

  schema = jsonencode([
    { name = "dates", type = "STRING", mode = "NULLABLE" },
    { name = "visitors", type = "INTEGER", mode = "NULLABLE" },
    { name = "pages_viewed", type = "INTEGER", mode = "NULLABLE" },
    { name = "cities", type = "STRING", mode = "NULLABLE" },

    { name = "food_articles", type = "FLOAT", mode = "NULLABLE" },
    { name = "wear_articles", type = "FLOAT", mode = "NULLABLE" },
    { name = "electronics_articles", type = "FLOAT", mode = "NULLABLE" },
    { name = "sports_articles", type = "FLOAT", mode = "NULLABLE" },
    { name = "toys_articles", type = "FLOAT", mode = "NULLABLE" },
    { name = "home_articles", type = "FLOAT", mode = "NULLABLE" },
    { name = "garden_articles", type = "FLOAT", mode = "NULLABLE" },
    { name = "beauty_articles", type = "FLOAT", mode = "NULLABLE" },
    { name = "automotive_articles", type = "FLOAT", mode = "NULLABLE" }
  ])
}
