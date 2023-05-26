DROP DATABASE IF EXISTS comics;
CREATE DATABASE comics;
USE comics;

CREATE TABLE publishers (
    id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);
DELIMITER //
CREATE TRIGGER capitalise_publisher_name
BEFORE INSERT ON publishers
FOR EACH ROW
BEGIN
    SET NEW.name = CONCAT(UPPER(SUBSTR(NEW.name, 1, 1)), SUBSTR(NEW.name, 2));
END //
DELIMITER ;

INSERT INTO publishers (id, name) VALUES 
    (1, 'Marvel Comics'),
    (2, 'DC Comics'),
    (3, 'image Comics'),
    (4, 'Dark Horse Comics'),
    (5, 'IDW Publishing'),
    (6, 'Boom! Studios'),
    (7, 'Valiant Comics'),
    (8, 'Top Cow Productions'),
    (9, 'Avatar Press'),
    (10, 'Archie Comics');

CREATE VIEW publishers_ordered AS
SELECT * FROM publishers ORDER BY name;
SELECT * FROM publishers_ordered;

SELECT name FROM publishers WHERE id = 3;
UPDATE publishers SET name = 'BOOM! Studios' WHERE id = 6;
DELETE FROM publishers WHERE id = 9;
INSERT INTO publishers (id, name) VALUES (11, 'Image Comics');

CREATE TABLE countries (
    country_code CHAR(2) PRIMARY KEY,
    country_name VARCHAR(255) NOT NULL
);
DELIMITER //
CREATE TRIGGER format_country_info
BEFORE INSERT ON countries
FOR EACH ROW
BEGIN
    SET NEW.country_code = UPPER(NEW.country_code);
    SET NEW.country_name = CONCAT(UCASE(LEFT(NEW.country_name, 1)), SUBSTRING(NEW.country_name, 2));
END //
DELIMITER ;

INSERT INTO countries (country_code, country_name)
VALUES 
('US', 'United States'),
('CA', 'Canada'),
('IE', 'Ireland'),
('rO', 'romania'),
('MX', 'Mexico'),
('GB', 'United Kingdom'),
('FR', 'France'),
('DE', 'Germany'),
('JP', 'Japan'),
('CN', 'China'),
('MD', 'Moldova'),
('AU', 'Australia');

CREATE VIEW country_codes AS
SELECT country_name, country_code
FROM countries;
SELECT * from country_codes;
SELECT country_name FROM countries WHERE country_code = 'US';

CREATE TABLE publisher_countries (
    publisher_id INT,
    country_code CHAR(2),
    PRIMARY KEY (publisher_id, country_code),
    FOREIGN KEY (publisher_id) REFERENCES publishers(id),
    FOREIGN KEY (country_code) REFERENCES countries(country_code)
);

INSERT INTO publisher_countries (publisher_id, country_code)
VALUES
(1, 'US'),
(1, 'CA'),
(1, 'GB'),
(1, 'JP'),
(2, 'US'),
(2, 'CA'),
(2, 'GB'),
(2, 'JP'),
(3, 'US'),
(3, 'CA'),
(4, 'US'),
(4, 'CA'),
(4, 'GB'),
(4, 'FR'),
(4, 'DE'),
(5, 'US'),
(5, 'CA'),
(6, 'US'),
(6, 'CA');

-- Create a view that retrieves all publishers and their corresponding countries
CREATE VIEW publisher_country_view AS
SELECT publishers.name AS publisher_name, countries.country_name
FROM publisher_countries
JOIN publishers ON publisher_countries.publisher_id = publishers.id
JOIN countries ON publisher_countries.country_code = countries.country_code;
select * from publisher_country_view;

-- Create a view that retrieves all the countries where a specific publisher operates
CREATE VIEW publisher_country_specific_view AS
SELECT publishers.name AS publisher_name, countries.country_name
FROM publisher_countries
JOIN publishers ON publisher_countries.publisher_id = publishers.id
JOIN countries ON publisher_countries.country_code = countries.country_code
WHERE publishers.name = 'Marvel Comics';
select * from publisher_country_specific_view;

-- Create a view that lists all publishers and their countries:
CREATE VIEW publisher_countries_view AS
SELECT publishers.name AS publisher_name, countries.country_name
FROM publisher_countries
JOIN publishers ON publisher_countries.publisher_id = publishers.id
JOIN countries ON publisher_countries.country_code = countries.country_code;

-- Create a view to retrieve all publishers and the number of countries they operate in:
CREATE VIEW publisher_country_count AS
SELECT publishers.name AS publisher_name, COUNT(*) AS country_count
FROM publisher_countries
JOIN publishers ON publisher_countries.publisher_id = publishers.id
GROUP BY publishers.name;
select * from publisher_country_count;

CREATE TABLE writers (
    id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);
DELIMITER //
CREATE TRIGGER capitalize_writer_name
BEFORE INSERT ON writers
FOR EACH ROW
BEGIN
  DECLARE first_letter CHAR(1);
  SET first_letter = LEFT(NEW.name, 1);
  SET NEW.name = CONCAT(UCASE(first_letter), SUBSTR(NEW.name, 2));
END //
DELIMITER ;

INSERT INTO writers (id, name) VALUES 
    (1, 'stan Lee'),
    (2, 'jack Kirby'),
    (3, 'steve Ditko'),
    (4, 'frank Miller'),
    (5, 'alan Moore'),
    (6, 'Neil Gaiman'),
    (7, 'Grant Morrison'),
    (8, 'Joss Whedon'),
    (9, 'Brian Michael Bendis'),
    (10, 'Geoff Johns');
-- View to show all writers
CREATE VIEW all_writers AS
SELECT * FROM writers;

-- View to display writers sorted by name:
CREATE VIEW writers_by_name AS
SELECT * FROM writers
ORDER BY name;
select * from writers_by_name;

CREATE TABLE artists (
    id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);
DELIMITER //
CREATE TRIGGER capitalize_artist_name
BEFORE INSERT ON artists
FOR EACH ROW
BEGIN
    SET NEW.name = CONCAT(UPPER(LEFT(NEW.name, 1)), SUBSTRING(NEW.name, 2));
END //
DELIMITER ;

INSERT INTO artists (id, name) VALUES 
    (1, 'jack Kirby'),
    (2, 'steve Ditko'),
    (3, 'frank Miller'),
    (4, 'todd McFarlane'),
    (5, 'Jim Lee'),
    (6, 'John Romita Jr.'),
    (7, 'George Perez'),
    (8, 'Alex Ross'),
    (9, 'David Mazzucchelli'),
    (10, 'Mike Mignola');

CREATE TABLE comics (
    id INT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    publisher_id INT,
    writer_id INT,
    artist_id INT,
    issue_number INT,
    publication_date DATE,
    FOREIGN KEY (publisher_id) REFERENCES publishers(id),
    FOREIGN KEY (writer_id) REFERENCES writers(id),
    FOREIGN KEY (artist_id) REFERENCES artists(id)
);
-- ensures the title column is always capitalized when inserting or updating a row
DELIMITER //
CREATE TRIGGER capitalize_title
BEFORE INSERT ON comics
FOR EACH ROW
BEGIN
    SET NEW.title = CONCAT(UCASE(LEFT(NEW.title, 1)), LCASE(SUBSTRING(NEW.title, 2)));
END//
DELIMITER ;

INSERT INTO comics (id, title, publisher_id, writer_id, artist_id, issue_number, publication_date) VALUES
(1, 'amazing Fantasy #15', 1, 1, 2, 15, '1962-08-01'),
(2, 'Fantastic Four #1', 1, 1, 1, 1, '1961-11-01'),
(3, 'The Dark Knight Returns #1', 4, 4, 3, 1, '1986-02-01'),
(4, 'Watchmen #1', 5, 5, 5, 1, '1986-09-01'),
(5, 'Sandman #1', 3, 6, 6, 1, '1989-01-01'),
(6, 'X-Men #1', 1, 7, 5, 1, '1991-10-01'),
(7, 'Batman: Year One #1', 4, 4, 9, 1, '1987-02-01'),
(8, 'Spawn #1', 3, 10, 4, 1, '1992-05-01'),
(9, 'The Walking Dead #1', 5, 6, 7, 1, '2003-10-01'),
(10, 'Saga #1', 6, 6, 8, 1, '2012-03-01');

-- A view that lists all the comics with their publisher name, writer name, and artist name
CREATE VIEW comics_details AS
SELECT comics.title, publishers.name AS publisher_name, writers.name AS writer_name, artists.name AS artist_name
FROM comics
JOIN publishers ON comics.publisher_id = publishers.id
JOIN writers ON comics.writer_id = writers.id
JOIN artists ON comics.artist_id = artists.id;
select * from comics_details;

-- A view that lists the top 5 publishers by the number of comics they have published
CREATE VIEW top_publishers AS
SELECT publishers.name, COUNT(comics.id) AS comic_count
FROM publishers
JOIN comics ON comics.publisher_id = publishers.id
GROUP BY publishers.id
ORDER BY comic_count DESC
LIMIT 5;
select * from top_publishers;

-- A view that lists all the comics that were published in the 1980s
CREATE VIEW comics_1980s AS
SELECT *
FROM comics
WHERE publication_date BETWEEN '1980-01-01' AND '1989-12-31';
select * from comics_1980s;

-- A view that lists all the writers who have written for more than one publisher
CREATE VIEW multi_publisher_writers AS
SELECT writers.name
FROM writers
JOIN comics ON comics.writer_id = writers.id
GROUP BY writers.id
HAVING COUNT(DISTINCT comics.publisher_id) > 1;
select * from multi_publisher_writers;

-- A view that lists all the comics with their publisher name, writer name, and artist name, 
-- but only includes comics with a publication date after 1990:
CREATE VIEW recent_comics_details AS
SELECT comics.title, publishers.name AS publisher_name, writers.name AS writer_name, artists.name AS artist_name
FROM comics
JOIN publishers ON comics.publisher_id = publishers.id
JOIN writers ON comics.writer_id = writers.id
JOIN artists ON comics.artist_id = artists.id
WHERE comics.publication_date > '1990-01-01';
select * from recent_comics_details;

-- This stored procedure takes a publisher name as input and returns a result set of comics 
-- published by that publisher, along with their writer and artist names.
DELIMITER //
CREATE PROCEDURE get_comics_by_publisher(IN publisher_name VARCHAR(255))
BEGIN
    SELECT c.title, p.name AS publisher, w.name AS writer, a.name AS artist
    FROM comics c
    INNER JOIN publishers p ON c.publisher_id = p.id
    INNER JOIN writers w ON c.writer_id = w.id
    INNER JOIN artists a ON c.artist_id = a.id
    WHERE p.name = publisher_name;
END //
DELIMITER ;

CREATE TABLE grades (
    id INT PRIMARY KEY,
    grade_name VARCHAR(10) NOT NULL,
    description VARCHAR(255) NOT NULL,
    grading DECIMAL(3,1) NOT NULL
);
-- grades should not be >10 or <0.1
delimiter //
CREATE TRIGGER insert_grade
BEFORE INSERT ON grades
FOR EACH ROW
BEGIN
  IF NEW.grading > 10 THEN
    SET NEW.grading = 10.0;
  ELSEIF NEW.grading < 0.1 THEN
    SET NEW.grading = 0.1;
  END IF;
END;//
delimiter ;

INSERT INTO grades (id, grade_name, description, grading) VALUES 
    (1, 'Mint', 'Perfect condition with no flaws', 10.0),
    (2, 'Near Mint', 'Almost perfect with only minor imperfections', 9.4),
    (3, 'Very Fine', 'Slight wear but still in excellent condition', 8.0),
    (4, 'Fine', 'Some wear but still in good condition', 6.0),
    (5, 'Very Good', 'Significant wear and tear but still readable', 4.0),
    (6, 'Good', 'Considerable wear and tear with some damage', 2.0),
    (7, 'Fair', 'Heavily worn with significant damage', 1.0),
    (8, 'Poor', 'Severely damaged and barely readable', 0.5),
    (9, 'Incomplete', 'Missing pages or other significant damage', 0.1),
    (10, 'Very Fine', 'Slight wear but still in excellent condition', 9.3);
    
-- View to calculate average grading of all grades
CREATE VIEW avg_grading AS
SELECT AVG(grading) AS avg_grading FROM grades;
select * from avg_grading;

-- View to count the number of grades in each category
CREATE VIEW grade_count AS
SELECT grade_name, COUNT(*) AS count FROM grades
GROUP BY grade_name;
select * from grade_count;

-- View to calculate the average grading for each category
CREATE VIEW avg_grading_by_grade AS
SELECT grade_name, AVG(grading) AS avg_grading FROM grades
GROUP BY grade_name;
select * from avg_grading_by_grade;

-- View to find the highest and the lowest graded items
CREATE VIEW high_low_grades AS
SELECT * FROM (
  SELECT *, RANK() OVER (ORDER BY grading DESC) AS rank_high,
         RANK() OVER (ORDER BY grading ASC) AS rank_low
  FROM grades
) AS ranked_grades
WHERE rank_high = 1 OR rank_low = 1;
select * from high_low_grades;

-- View to show the difference between the grading of each item and the average grading
CREATE VIEW diff_from_avg AS
SELECT *, grading - (SELECT avg_grading FROM avg_grading) AS diff
FROM grades;
select * from diff_from_avg;

INSERT INTO grades (id, grade_name, description, grading)
VALUES (11, 'Excellent', 'Excellent condition with no flaws', 11.0);
INSERT INTO grades (id, grade_name, description, grading)
VALUES (12, 'Poor', 'Poor condition', -2);

CREATE TABLE comic_grades (
    comic_id INT,
    grade_id INT,
    price DECIMAL(10, 2),
    PRIMARY KEY (comic_id, grade_id),
    FOREIGN KEY (comic_id) REFERENCES comics(id),
    FOREIGN KEY (grade_id) REFERENCES grades(id)
);
-- This trigger will check the maximum grading for the grade_id of a newly inserted row in 
-- the comic_grades table, and if the price of the row is greater than the maximum grading, 
-- it will set the price to the maximum grading.
DELIMITER //
CREATE TRIGGER check_comic_price
BEFORE INSERT ON comic_grades
FOR EACH ROW
BEGIN
    DECLARE max_price DECIMAL(10, 2);
    SELECT grading INTO max_price FROM grades WHERE id = NEW.grade_id;
    IF NEW.price > max_price THEN
        SET NEW.price = max_price;
    END IF;
END //
DELIMITER ;

INSERT INTO comic_grades (comic_id, grade_id, price) VALUES
(1, 2, 2500.00),
(1, 3, 1500.00),
(2, 2, 2200.00),
(2, 3, 1200.00),
(3, 1, 4500.00),
(3, 2, 2500.00),
(4, 1, 5000.00),
(4, 2, 3000.00),
(5, 1, 2000.00),
(5, 2, 1000.00),
(6, 3, 500.00),
(7, 2, 2000.00),
(8, 2, 1000.00),
(9, 1, 800.00),
(10, 1, 400.00);

-- Show the top 5 most expensive comics
SELECT comics.title, comic_grades.price
FROM comics
JOIN comic_grades ON comic_grades.comic_id = comics.id
ORDER BY comic_grades.price DESC
LIMIT 5;

CREATE TABLE collections (
    id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    owner_name VARCHAR(255) NOT NULL
);
DELIMITER //
CREATE TRIGGER capitalize_collection_names
BEFORE INSERT ON collections
FOR EACH ROW
BEGIN
    SET NEW.name = CONCAT(UCASE(LEFT(NEW.name, 1)), SUBSTRING(NEW.name, 2));
    SET NEW.owner_name = CONCAT(UCASE(LEFT(NEW.owner_name, 1)), SUBSTRING(NEW.owner_name, 2));
END//
DELIMITER ;

INSERT INTO collections (id, name, owner_name)
VALUES 
  (1, 'marvel Comics', 'john'),
  (2, 'DC Comics', 'Sarah'),
  (3, 'Image Comics', 'David'),
  (4, 'Dark Horse Comics', 'Jessica'),
  (5, 'Vertigo Comics', 'Gabriel'),
  (6, 'Manga Collection', 'Emily'),
  (7, 'Graphic Novels Collection', 'Daniel'),
  (8, 'Classic Comics', 'Laura'),
  (9, 'Indie Comics', 'Robert'),
  (10, 'Webcomics Collection', 'Jennifer');

CREATE TABLE collection_comics (
    collection_id INT,
    comic_id INT,
    grade_id INT,
    condition_notes TEXT,
    PRIMARY KEY (collection_id, comic_id, grade_id),
    FOREIGN KEY (collection_id) REFERENCES collections(id),
    FOREIGN KEY (comic_id) REFERENCES comics(id),
    FOREIGN KEY (grade_id) REFERENCES grades(id)
);

INSERT INTO collection_comics (collection_id, comic_id, grade_id, condition_notes)
VALUES
(1, 2, 3, 'Minor creases on front cover, but overall in good condition.'),
(1, 4, 1, 'Torn back cover, missing pages, fair condition at best.'),
(2, 3, 2, 'Slight discolouration on spine, otherwise excellent condition.'),
(2, 5, 4, 'Light wear on edges and corners, very good condition.'),
(3, 1, 5, 'Practically mint condition, no visible flaws.'),
(3, 2, 4, 'Moderate spine stress, some minor scuffing, good condition overall.'),
(4, 6, 3, 'Small tear on front cover, otherwise very good condition.'),
(4, 7, 2, 'Slight warping and minor wear, but still in decent condition.'),
(5, 2, 1, 'Heavily creased cover, water damage on bottom edge, poor condition.'),
(5, 8, 5, 'Near-perfect condition, only the slightest signs of wear on the spine.');

-- Show the comics in each collection with their grades and condition notes
SELECT 
  cc.collection_id, 
  c.title, 
  g.grade_name, 
  cc.condition_notes 
FROM collection_comics cc 
JOIN comics c ON cc.comic_id = c.id 
JOIN grades g ON cc.grade_id = g.id;

-- Show the total value of each collection based on the condition of the comics
SELECT 
  cc.collection_id, 
  SUM(g.grading * cg.price) AS total_value
FROM collection_comics cc 
JOIN comic_grades cg ON cc.comic_id = cg.comic_id AND cc.grade_id = cg.grade_id 
JOIN grades g ON cc.grade_id = g.id 
GROUP BY cc.collection_id;

-- View to show the collections with the most expensive comics
CREATE VIEW expensive_collections_view AS
SELECT 
  c.id AS collection_id, 
  c.name AS collection_name, 
  SUM(cg.price) AS total_price
FROM collections c 
JOIN collection_comics cc ON c.id = cc.collection_id 
JOIN comic_grades cg ON cc.comic_id = cg.comic_id AND cc.grade_id = cg.grade_id 
GROUP BY c.id 
ORDER BY total_price DESC;
select * from expensive_collections_view;

SET SQL_SAFE_UPDATES = 0;

DELIMITER //
CREATE PROCEDURE update_collection_comic_notes(IN collection_id INT, IN comic_id INT, IN grade_id INT, IN new_notes TEXT)
BEGIN
    UPDATE collection_comics
    SET condition_notes = new_notes
    WHERE collection_id = collection_id AND comic_id = comic_id AND grade_id = grade_id;
END //
DELIMITER ;

SELECT c.title, c.issue_number, c.publication_date, w.name AS writer_name, a.name AS artist_name
FROM comics c
JOIN writers w ON c.writer_id = w.id
JOIN artists a ON c.artist_id = a.id
WHERE c.publisher_id = 1;