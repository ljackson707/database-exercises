use albums_db;

#Explore Structure of Albums
Describe albums;

#Explore content
SELECT *
FROM albums;

#Explore Distinct column
SELECT DISTINCT genre
FROM albums;

#The name of all albums by Pink Floyd (With Alias)
SELECT name , artist
FROM albums
WHERE artist = 'Pink Floyd';

#ALias
SELECT name AS 'Albums by Pink Floyd'
FROM albums
WHERE artist = 'Pink Floyd';

#The year Sgt. Pepper's Lonely Hearts Club Band was released (Use backslash to opt out the ')
SELECT name , release_date
FROM albums
WHERE name = 'Sgt. Pepper\'s Lonely Hearts Club Band';

#The genre for the album Nevermind
SELECT genre , name 
FROM albums
WHERE name = 'Nevermind';

#Which albums were released in the 1990s
SELECT name , release_date
FROM albums
WHERE release_date between 1990 and 1999;

#Which albums had less than 20 million certified sales
SHOW CREATE TABLE albums; #To check the format of the sales column.
SELECT name , sales
FROM albums
WHERE sales < 20.0;

#All the albums with a genre of "Rock". Why do these query results not include albums with a genre of "Hard rock" or "Progressive rock"?\
SHOW CREATE TABLE albums;
SELECT *
FROM albums
WHERE genre = 'Rock'; 

#There is a genre of just "Rock". If we wanted to ve it include all rock genres then we would use a concat and alias. 

# Or you can use the LIKE operand
SHOW CREATE TABLE albums;
SELECT *
FROM albums
WHERE genre LIKE '%Rock,%';