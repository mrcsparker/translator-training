CREATE DATABASE IF NOT EXISTS `movies`;

USE `movies`;

CREATE TABLE IF NOT EXISTS `genres` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `genres_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `links` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `movie_id` int(11) NOT NULL,
  `imdb_id` varchar(255) DEFAULT NULL,
  `tmdb_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `links_movie_id` (`movie_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `movie_genres` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `movie_id` int(11) NOT NULL,
  `genre_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `movie_genres_movie_id_genre_id` (`movie_id`,`genre_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `movies` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL DEFAULT '',
  `year` int(11) unsigned,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ratings` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `movie_id` int(11) NOT NULL,
  `rating` decimal(11,2) NOT NULL,
  `timestamp` bigint(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ratings_movie_id` (`movie_id`),
  KEY `ratings_user_id` (`user_id`),
  KEY `ratings_rating` (`rating`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `tags` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `movie_id` int(11) NOT NULL,
  `tag` varchar(255) NOT NULL DEFAULT '',
  `timestamp` bigint(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tags_movie_id` (`movie_id`),
  KEY `tags_user_id` (`user_id`),
  KEY `tags_tag` (`tag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
