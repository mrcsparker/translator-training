library('rvest')
library('dplyr')

data <- read_html('./ndxl-cleaned.html')

data %>%
  html_table(header = TRUE) %>%
  data.frame() %>%
  tbl_df() -> data_table

headers <- function() {
  c("date", "city", "state", "shape", "duration", "summary", "posted")
}

as_table <- function(c) {
  c %>% write.table(row.names = F, col.names = headers())
}

as_csv <- function(c) {
  c %>%
    write.table(file = "ndxl.csv",
                row.names = F,
                sep = ',',
                col.names = headers())
}
