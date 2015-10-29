do_install <- function(packages) {
  for (package in packages) {
    if (!require('packages')) {
      install.packages(package, repos='http://cran.us.r-project.org')
    }
  }
}

packages = c('rvest', 'dplyr', 'methods')

do_install(packages)
