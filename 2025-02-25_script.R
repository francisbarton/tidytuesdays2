# https://github.com/rfordatascience/tidytuesday/tree/main/data/2025/2025-02-25

kc_url <- \(x) paste0("https://kcorreia.people.amherst.edu/", x)
crep <- \(x, y) paste0(rep(x, y), collapse = "")

# 318 rows
articles_data <- kc_url("repro_med_disparities-article-level-data.csv") |>
  readr::read_csv(col_types = paste0(
    "iccccccccccciicc",
    crep("ci", 16),
    crep("i", 17)
  ))

model_dat <- readr::read_csv(
  "https://kcorreia.people.amherst.edu/repro_med_disparities-model-level-data.csv"
)
