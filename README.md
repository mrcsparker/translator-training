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

__ubuntu-trusty-14.04-amd64-server__

```bash
apt-get update
apt-get -y upgrade

apt-get install -y libcurl4-openssl-dev
apt-get install -y libgstreamer-plugins-base0.10-0
apt-get install -y gdebi-core
apt-get install -y libapparmor1
apt-get install -y libxml2-dev
apt-get install -y libcurl4-gnutls-dev
apt-get install -y git
```

### R

```
echo 'deb http://cran.cnr.Berkeley.edu/bin/linux/ubuntu trusty/' >> /etc/apt/sources.list

# Secure APT
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9

apt-get update
apt-get install -y r-base r-base-dev
```

Set a default R mirror

```
cat >> /etc/R/Rprofile.site << EOF
local({
  # add MASS to the default packages, set a CRAN mirror
  old <- getOption("defaultPackages"); r <- getOption("repos")
  r["CRAN"] <- "http://cran.rstudio.com"
  options(defaultPackages = c(old, "MASS"), repos = r)
})
EOF
```

Install RStudio server

```
cd /tmp
wget http://download2.rstudio.org/rstudio-server-0.99.467-amd64.deb
gdebi -n rstudio-server-0.99.467-amd64.deb
```

for each user:

`mkdir -p ~/R/x86_64-pc-linux-gnu-library/3.2`

### MySQL

```
apt-get install -y mysql-server
apt-get install -y libmysqlclient-dev
```

### Golang

```
cd /tmp
wget https://storage.googleapis.com/golang/go1.5.1.linux-amd64.tar.gz
tar -C /opt/ -xzf go1.5.1.linux-amd64.tar.gz
```

```
cat >> /etc/profile.d/golang.sh << EOF
if [ -d "/opt/go/bin" ] ; then
    export PATH="/opt/go/bin:$PATH"
fi
EOF

chmod +x /etc/profile.d/golang.sh

```

### NGINX

```
apt-get -y install nginx-full
```

`vim /etc/nginx/nginx.conf`

```
http {
        ...

        map $http_upgrade $connection_upgrade {
                default upgrade;
                ''      close;
        }
```

`vim /etc/nginx/sites-enabled/default`

```
        location /rstudio/ {
                rewrite ^/rstudio/(.*)$ /$1 break;
                proxy_pass http://localhost:8787;
                proxy_redirect http://localhost:8787/ $scheme://$host/rstudio/;
                proxy_http_version 1.1;
                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header Connection $connection_upgrade;
                proxy_read_timeout 20d;
        }
```

### R support packages

`R -f install-r-packages.R`

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

echo "create database if not exists movies" | mysql -u root
```

`vim /etc/nginx/sites-enabled/default`

```
        location /json-server/ {
                rewrite ^/json-server/(.*)$ /$1 break;
                proxy_pass http://localhost:8080;
                proxy_redirect http://localhost:8080/ $scheme://$host/json-server/;
                proxy_http_version 1.1;
                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header Connection $connection_upgrade;
                proxy_read_timeout 20d;
        }
```
