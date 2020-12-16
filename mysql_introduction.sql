# * Means all columns from a database file
SELECT * FROM mysql.user;

# Only showing user and host columns
SELECT user, host FROM mysql.user;

#All the rows beacuse we use * from the help_topic table of the MySQL database
SELECT * FROM mysql.help_topic;

#
SELECT help_topic_id, help_category_id, url FROM mysql.help_topic;

