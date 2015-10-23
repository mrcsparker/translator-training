# Data Pipeline with Drake

Simple ETL process that uses multiple tools written in various languages.

The process takes an HTML file, cleans it up with HTML Tidy, converts it to a CSV file with GNU R, and saves it as a SQLite3 database.

[HTML file] => [HTML Tidy] => [R CSV conversion] => [SQLite3 database from CSV]

Tools used:

* Drake https://github.com/Factual/drake
* HTML Tidy
* Standard Unix commands
* GNU R with packages
    - rvest
    - dplyr
* sqlite3

## Running

Type `drake` from the command line.

## Note

This same process can be done via a simple shell script or a Makfile.  Drake just makes this process easy to debug.

