# * Means all columns from a database file
SELECT * FROM mysql.user;

# Only showing user and host columns
SELECT user, host FROM mysql.user;

# All the rows beacuse we use * from the help_topic table of the MySQL database
SELECT * FROM mysql.help_topic;

# Selecting only the help_topic_id and help_category_id column from mysql.help_topic
SELECT help_topic_id, help_category_id, url FROM mysql.help_topic;

# Kinda like ls for all databases
show databases;

# Sets our current databse to fruits.db
USE fruits_db;

# Show the currently selected DB, kinda like pwd
SELECT databases();

# Show the code that created this specific database
SHOW CREATE DATABASE fruits_db;

# Quoting indetifiers
USE `sakila`

