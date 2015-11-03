# Need prepared statements support:
#   - devtools::install_github("rstats-db/DBI")
#   - devtools::install_github("rstats-db/RMySQL")
#
# Some useful keyboard shortcuts for package authoring:
#
#   Build and Reload Package:  'Cmd + Shift + B'
#   Check Package:             'Cmd + Shift + E'
#   Test Package:              'Cmd + Shift + T'

library(R6)
library(DBI)
library(RMySQL)
library(dplyr)
library(jsonlite)

#' DB Class
#' #'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' @format An \code{\link{R6Class}} generator object
#' @keywords data
DB <- R6Class("R6",
  public = list(
    conn = NA,

    initialize = function() {
      self$conn <- src_mysql(dbname = "movies", user = "root", password = "", host = "localhost")
    },

    sendQuery = function(s) {
      self$conn %>% tbl(sql(s))
    },

    moviesByYear = function() {
      self$conn %>%
        tbl("movies") %>%
        filter(year > 2010) %>%
        group_by(year) %>%
        summarize(count = n())
    },

    moviesWithRatings = function() {
      movies <- self$conn %>% tbl("movies")
      ratings <- self$conn %>% tbl("ratings")

      movies %>% inner_join(ratings, by = c("id" = "movie_id"))
    },

    moviesByGenreAndYear = function(genreName, year) {
      query <- paste("SELECT movies.*, ",
                     "genres.name as genre_name ",
                     "FROM movies ",
                     "INNER JOIN movie_genres ON movie_genres.movie_id = movies.id ",
                     "INNER JOIN genres ON genres.id = movie_genres.genre_id ",
                     "WHERE year = ", year, " ",
                     "AND genres.name LIKE '%", genreName, "%'",
                     sep = "")
      self$sendQuery(query)
    },

    ratingsByMovieId = function(movieId) {
      self$conn %>%
        tbl("ratings") %>%
        filter(movie_id == movieId)
    },

    insertChart = function(chartName, chartJson) {

      # PreparedStatements are not available in
      # the current stable version of RMySQL, so
      # we have to concatenate strings
      query <-
        paste("INSERT INTO services ( ",
              "name, json ",
              ") VALUES ( ",
              "'", chartName, "',",
              "'", chartJson, "'",
              ")", sep = "")

      self$conn$con %>% dbSendQuery(query)
    },

    updateChart = function(chartName, chartJson) {
      query <-
        paste("UPDATE services ",
              "SET name = '", chartName, "', ",
              "json = '", chartJson, "' ",
              "WHERE name = '", chartName, "'", sep = "")

      self$conn$con %>% dbSendQuery(query)
    },

    saveChart = function(chartName, chartJson) {
      services <- self$conn %>% tbl("services") %>%
        filter(name == chartName) %>%
        summarize(count = n()) %>%
        collect()

      if (services$count == 0) {
        self$insertChart(chartName, chartJson)
      } else {
        self$updateChart(chartName, chartJson)
      }
    }
  )
)

doRatingsForHorror <- function() {
  results <- list()

  db <- DB$new()
  movies <- db$moviesByGenreAndYear("Mystery", "2015") %>% head(5) %>% collect()
  for (i in 1:nrow(movies)) {
    movie <- movies[i,]

    results[movie$title] = db$ratingsByMovieId(movie$id) %>% select(rating) %>% collect()
  }

  json <- results %>% toJSON()

  db$saveChart("mrcsparker1", gsub("'", "", json))

  json
}
