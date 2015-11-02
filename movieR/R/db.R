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
      self$conn %>% tbl("movies") %>% filter(year > 2010) %>% group_by(year) %>% summarize(count = n())
    },

    moviesWithRatings = function() {
      movies <- self$conn %>% tbl("movies")
      ratings <- self$conn %>% tbl("ratings")

      movies %>% inner_join(ratings, by = c("id" = "movie_id"))
    },

    insertChart = function(chartName, chartType, chartJson) {
      self$conn$con %>%
        dbSendQuery(paste("INSERT INTO services ( ",
                          "name, chart_type, json ",
                          ") VALUES ( ",
                          ":name, :chartType, :json ",
                          ")"),
                    params = list(name = chartName,
                                  chartType = chartType,
                                  json = chartJson))
    },

    updateChart = function(chartName, chartType, chartJson) {
      self$conn$con %>%
        dbSendQuery(paste("UPDATE services ",
                          "SET name = :name, ",
                          "chart_type = :chartType, ",
                          "json = :json ",
                          "WHERE name = :name AND chart_type = :chartType"),
                    params = list(name = chartName,
                                  chartType = chartType,
                                  json = chartJson))
    },

    saveChart = function(chartName, chartType, chartJson) {
      services <- self$conn %>% tbl("services") %>%
        filter(name == chartName, chart_type == chartType) %>%
        summarize(count = n()) %>%
        collect()

      if (services$count == 0) {
        self$insertChart(chartName, chartType, chartJson)
      } else {
        self$updateChart(chartName, chartType, chartJson)
      }

    }
  )
)
