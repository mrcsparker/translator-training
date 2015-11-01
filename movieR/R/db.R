# Hello, world!
#
# This is an example function named 'hello'
# which prints 'Hello, world!'.
#
# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Build and Reload Package:  'Cmd + Shift + B'
#   Check Package:             'Cmd + Shift + E'
#   Test Package:              'Cmd + Shift + T'

library(R6)
library(RMySQL)
library(dplyr)
library(jsonlite)

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
      self$conn %>% tbl("movies") %>% filter(year > 2010) %>% group_by(year) %>% summarize(n())
    },

    moviesWithRatings = function() {
      movies <- self$conn %>% tbl("movies")
      ratings <- self$conn %>% tbl("ratings")

      movies %>% inner_join(ratings, by = c("id" = "movie_id"))
    },

    saveChart = function(chartName, chartType, chartJson) {
      service <- self$conn %>% tbl("services") %>% filter(name = chartName, type = chartType)
    }
  )
)
