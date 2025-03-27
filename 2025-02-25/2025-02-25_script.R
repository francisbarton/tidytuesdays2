# https://github.com/rfordatascience/tidytuesday/tree/main/data/2025/2025-02-25

library(dplyr)
library(ggplot2)

kc_url <- \(x) paste0("https://kcorreia.people.amherst.edu/", x)
crep <- \(x, y) paste0(rep(x, y), collapse = "")

# 318 rows
article_level_data <- kc_url("repro_med_disparities-article-level-data.csv") |>
  readr::read_csv(
    col_types = paste0("iccccccccccciicc", crep("ci", 16), crep("i", 17))
  ) |>
  dplyr::mutate(
    across("study_type", \(x) {
      dplyr::case_match(
        x,
        "Retrospective Cohort" ~ "Retrospective cohort",
        "Prospective Cohort" ~ "Prospective cohort",
        "Cross-Sectional" ~ "Cross-sectional",
        .default = x
      )
    })
  )

# 6804 rows
model_level_data <- kc_url("repro_med_disparities-model-level-data.csv") |>
  readr::read_csv(col_types = "cicccccccciccddd") |>
  dplyr::mutate(
    across(c("stratified", "subanalysis"), \(x) {
      if_else(x == "No", 0L, 1L, NA)
    })
  )

article_level_data |>
  dplyr::count(study_location, sort = TRUE) |>
  View()


focus_set <- article_level_data |>
  dplyr::filter(
    if_any("study_type", \(x) x == "Retrospective cohort") &
      if_any("study_location", \(x) x == "USA")
  )
