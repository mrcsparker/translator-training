# translator-training

Translator training hands-on materials.

This application contains the following modules:

## movie-pipeline

languages: Drake, Ruby, Unix shell, SQL

ETL pipeline that takes movie data from http://grouplens.org and
converts it to a MySQL data dump.

## movieR

languages: R

R library to help analyze the `movies` database.

## json-server

languages: golang

Simple JSON server

## json-client

languages: Javascript using EmberJS

Simple JSON client that connects to `json-server`

## Setup


for each user:

`mkdir -p ~/R/x86_64-pc-linux-gnu-library/3.2`

### Golang server

```
mkdir ~/.go

echo "export GOROOT=/opt/go" >> ~/.bashrc
echo "export export GOPATH=$HOME/.go" >> ~/.bashrc
echo "export PATH=$PATH:$GOROOT/bin:$GOPATH/bin" >> ~/.bashrc
source ~/.bashrc

go get -u github.com/ant0ine/go-json-rest/rest
go get -u github.com/jinzhu/gorm
go get -u github.com/go-sql-driver/mysql

```
