JOINS
-- Get all invoices where the unit_price on the invoice_line is greater than $0.99.
SELECT *
FROM invoice_line invl
JOIN invoice inv ON inv.invoice_id = invl.invoice_id
WHERE unit_price>0.99;
-- Get the invoice_date, customer first_name and last_name, and total from all invoices.
SELECT invoice_date, first_name, last_name, total
FROM INVOICE inv
JOIN CUSTOMER cus ON inv.customer_id = cus.customer_id;
-- Get the customer first_name and last_name and the support rep's first_name and last_name from all customers.
-- Support reps are on the employee table.
SELECT c.first_name, c.last_name, e.first_name, e.last_name
FROM customer c
JOIN employee e ON c.support_rep_id = e.employee_id;
-- Get the album title and the artist name from all albums.
SELECT al.title, a.name
FROM album al
JOIN artist a ON al.artist_id = a.artist_id;
-- Get all playlist_track track_ids where the playlist name is Music.
SELECT track_id
FROM playlist_track pt
JOIN playlist pl ON pt.playlist_id = pl.playlist_id
WHERE pl.name = 'Music';
-- Get all track names for playlist_id 5.
SELECT t.name
FROM track t
JOIN playlist_track pl ON t.track_id = pl.track_id
WHERE pl.playlist_id = 5;
-- Get all track names and the playlist name that they're on ( 2 joins ).
SELECT t.name, pl.name
FROM track t
JOIN playlist_track pt ON t.track_id = pt.track_id
JOIN playlist pl ON pl.playlist_id = pt.playlist_id;
-- Get all track names and album titles that are the genre Alternative & Punk ( 2 joins ).
SELECT t.name, al.title
FROM track t
JOIN album al ON t.album_id = al.album_id
JOIN genre gr ON t.genre_id = gr.genre_id
WHERE gr.name = 'Alternative & Punk'

NESTED QUERIES
-- Get all invoices where the unit_price on the invoice_line is greater than $0.99.
SELECT *
FROM invoice i
WHERE invoice_id IN(
  SELECT invoice_id
  FROM invoice_line
  WHERE unit_price>0.99
 );
-- Get all playlist tracks where the playlist name is Music.
SELECT *
FROM playlist_track 
WHERE playlist_id
IN(
  SELECT playlist_id
  FROM playlist
  WHERE name = 'Music'
 );
-- Get all track names for playlist_id 5.
SELECT name
FROM track
WHERE track_id
IN(
  SELECT track_id
  FROM playlist_track
  WHERE playlist_id = 5
);
-- Get all tracks where the genre is Comedy.
SELECT *
FROM track
WHERE genre_id
IN(
  SELECT genre_id
  FROM genre
  WHERE name = 'Comedy'
);
-- Get all tracks where the album is Fireball.
SELECT *
FROM track
WHERE album_id
IN(
	SELECT album_id
  FROM album
  WHERE name = 'Fireball'
);
-- Get all tracks for the artist Queen ( 2 nested subqueries ).
SELECT *
FROM track
WHERE album_id
IN(
	SELECT album_id
  FROM album
  WHERE artist_id 
  	IN(
  	SELECT artist_id
  	FROM artist
  	WHERE(name = 'Queen')
  )
);

UPDATING ROWS

-- Find all customers with fax numbers and set those numbers to null.
UPDATE customer
SET fax = NULL
WHERE fax IS NOT NULL;
-- Find all customers with no company (null) and set their company to "Self".
UPDATE customer
SET company= 'Self'
WHERE company IS NULL;
-- Find the customer Julia Barnett and change her last name to Thompson.
UPDATE customer
SET last_name = 'Thompson'
WHERE first_name = 'Julia' AND last_name = 'Barnett'
-- Find the customer with this email luisrojas@yahoo.cl and change his support rep to 4.
UPDATE customer
SET support_rep_id = 4
WHERE email = 'luisrojas@yahoo.cl';
-- Find all tracks that are the genre Metal and have no composer. Set the composer to "The darkness around us".
UPDATE track
SET composer ='The darkness around us'
WHERE genre_id =(SELECT genre_id FROM genre WHERE name = 'Metal')
AND composer IS NULL;
-- Refresh your page to remove all database changes.

GROUP BY

-- Find a count of how many tracks there are per genre. Display the genre name with the count.
SELECT COUNT(*), g.name
FROM track t
JOIN genre g ON t.genre_id = g.genre_id
GROUP BY g.name
-- Find a count of how many tracks are the "Pop" genre and how many tracks are the "Rock" genre.
SELECT COUNT(*), g.name
FROM track t
JOIN genre g ON t.genre_id = g.genre_id
WHERE g.name ='Rock' OR g.name = 'Pop'
GROUP BY g.name;
-- Find a list of all artists and how many albums they have.
SELECT a.name, COUNT(*)
FROM album al
JOIN artist a ON al.artist_id = a.artist_id
GROUP BY a.name;


USE DISTINCT

-- From the track table find a unique list of all composers.
SELECT DISTINCT composer
FROM track
-- From the invoice table find a unique list of all billing_postal_codes.
SELECT DISTINCT billing_postal_code
FROM invoice
-- From the customer table find a unique list of all companys.
SELECT DISTINCT company
FROM customer

DELETE ROWS

-- Copy, paste, and run the SQL code from the summary.
-- Delete all 'bronze' entries from the table.
DELETE FROM practice_delete
WHERE type= 'bronze';
-- Delete all 'silver' entries from the table.
DELETE FROM practice_delete
WHERE type= 'silver';
-- Delete all entries whose value is equal to 150.
DELETE FROM practice_delete
WHERE value= 150;

eCOMMERCE SIMULATION
SUMMARY

-- Instructions
-- Create 3 tables following the criteria in the summary.
    CREATE TABLE users (users_id SERIAL, name VARCHAR(50), email VARCHAR(50));
    CREATE TABLE products (products_id SERIAL, name VARCHAR(50), price NUMERIC);
    CREATE TABLE orders (orders_id SERIAL, products_id INTEGER);
-- Add some data to fill up each table.
-- At least 3 users, 3 products, 3 orders.
    INSERT INTO users(name, email)
    VALUES
    ('Zach', z@gmail.com)
    ('Aaron', aron@gmail.com)
    ('Billy', billyb@gmail.com)
    ('Christine', chris@gmail.com);
    INSERT INTO products(name, price)
    VALUES
    ('toy boat', 2.99)
    ('baseball card pack', 4.99)
    ('ford ranger door', 253.87)
    ('entry door', 214.99)
    