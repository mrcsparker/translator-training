library('rvest')
library('dplyr')
library('methods')

headers <- function() {
  c("incident_date", "city", "state", "shape", "duration", "summary", "posted")
}

as_table <- function(c) {
  c %>% write.table(row.names = F, col.names = headers())
}

as_csv <- function(c) {
  c %>%
    write.table(file = "ndxl.csv",
                row.names = F,
                sep = ',',
                eol = "\n",
                qmethod = 'escape',
                col.names = headers())
}

as_output <- function(c) {
   c %>%
    write.table(file = "/dev/stdout",
                row.names = F,
                sep = ',',
                eol = "\n",
                qmethod = 'escape',
                col.names = headers())
}

read_stdin <- function() {
  options(max.print = 1000000)
  input <- paste(readLines(con <- file("stdin")), collapse = " ")
  close(con)
  input
}

main <- function() {
  data <- read_stdin()

  data %>%
    read_html() %>%
    html_table(header = TRUE) %>%
    data.frame() %>%
    tbl_df() %>%
    as_output()
}

main()

