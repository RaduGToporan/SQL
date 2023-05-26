drop database if exists movies;
create database movies;
use movies;

CREATE TABLE features (
    feature_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    year_of_release YEAR,
    type VARCHAR(100) NOT NULL
);
insert into features(title, year_of_release, type)
values ('Dr. No', 1962, 'Movie'),
('From Russia with Love', 1963, 'Movie'),
('Goldfinger', 1964, 'Movie'),
('Thunderball', 1965, 'Movie'),
  ('You Only Live Twice', 1967, 'Movie'),
  ('On Her Majesty''s Secret Service', 1969, 'Movie'),
  ('Diamonds Are Forever', 1971, 'Movie'),
  ('Live and Let Die', 1973, 'Movie'),
  ('The Man with the Golden Gun', 1974, 'Movie'),
  ('The Spy Who Loved Me', 1977, 'Movie'),
  ('Moonraker', 1979, 'Movie'),
  ('For Your Eyes Only', 1981, 'Movie'),
  ('Octopussy', 1983, 'Movie'),
  ('A View to a Kill', 1985, 'Movie'),
  ('The Living Daylights', 1987, 'Movie'),
  ('Licence to Kill', 1989, 'Movie'),
  ('GoldenEye', 1995, 'Movie'),
  ('Tomorrow Never Dies', 1997, 'Movie'),
  ('The World Is Not Enough', 1999, 'Movie'),
  ('Die Another Day', 2002, 'Movie'),
  ('Casino Royale', 2006, 'Movie'),
  ('Quantum of Solace', 2008, 'Movie'),
  ('Skyfall', 2012, 'Movie'),
  ('Spectre', 2015, 'Movie'),
  ('No Time To Die', 2022, 'Movie'),
('20,000 Leagues Under the Sea', 1954 , 'Movie'),
('The Old Man and the Sea', 1958 , 'Movie'),
('Les Misérables', 1998, 'Movie'),
('The Old Man and the Sea', 1958 , 'Movie'),
("Alaska's Deadliest", 1998, 'TV show'),
("Clarkson's Farm", 2021, 'TV show'),
("Bill Nye the Science Guy", 1993, 'TV show'),
('Planet Earth', 2006, 'TV show'),
('The Name of the Rose', 1986, 'Movie'),
('Inchon', 1981, 'Movie'),
('Force 10 from Navarone', 1978, 'Movie'),
('H.M.S. Defiant', 1962, 'Movie');

CREATE TABLE feature_work (
    work_id INT AUTO_INCREMENT PRIMARY KEY,
    FK_feature_id INT NOT NULL,
    person_name VARCHAR(100) NOT NULL,
    work_type VARCHAR(100) NOT NULL,
    FOREIGN KEY (FK_feature_id)
        REFERENCES features (feature_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO feature_work (FK_feature_id, person_name, work_type) VALUES
-- James Bond Movies
(1, 'Sean Connery', 'Actor'),
(1, 'Terence Young', 'Director'),
(2, 'Sean Connery', 'Actor'),
(2, 'Terence Young', 'Director'),
(3, 'Sean Connery', 'Actor'),
(3, 'Guy Hamilton', 'Director'),
(4, 'Sean Connery', 'Actor'),
(4, 'Terence Young', 'Director'),
(5, 'Sean Connery', 'Actor'),
(5, 'Lewis Gilbert', 'Director'),
(6, 'George Lazenby', 'Actor'),
(6, 'Peter R. Hunt', 'Director'),
(7, 'Sean Connery', 'Actor'),
(7, 'Guy Hamilton', 'Director'),
(8, 'Roger Moore', 'Actor'),
(8, 'Guy Hamilton', 'Director'),
(9, 'Roger Moore', 'Actor'),
(9, 'Guy Hamilton', 'Director'),
(10, 'Roger Moore', 'Actor'),
(10, 'Lewis Gilbert', 'Director'),
(11, 'Roger Moore', 'Actor'),
(11, 'Lewis Gilbert', 'Director'),
(12, 'Roger Moore', 'Actor'),
(12, 'John Glen', 'Director'),
(13, 'Roger Moore', 'Actor'),
(13, 'John Glen', 'Director'),
(14, 'Roger Moore', 'Actor'),
(14, 'John Glen', 'Director'),
(15, 'Timothy Dalton', 'Actor'),
(15, 'John Glen', 'Director'),
(16, 'Timothy Dalton', 'Actor'),
(16, 'John Glen', 'Director'),
(17, 'Pierce Brosnan', 'Actor'),
(17, 'Martin Campbell', 'Director'),
(18, 'Pierce Brosnan', 'Actor'),
(18, 'Roger Spottiswoode', 'Director'),
(19, 'Pierce Brosnan', 'Actor'),
(19, 'Michael Apted', 'Director'),
(20, 'Pierce Brosnan', 'Actor'),
(20, 'Lee Tamahori', 'Director'),
(21, 'Daniel Craig', 'Actor'),
(21, 'Martin Campbell', 'Director'),
(22, 'Daniel Craig', 'Actor'),
(22, 'Marc Forster', 'Director'),
(23, 'Daniel Craig', 'Actor'),
(23, 'Sam Mendes', 'Director'),
(24, 'Daniel Craig', 'Actor'),
(24, 'Sam Mendes', 'Director'),
(25, 'Daniel Craig', 'Actor'),
(25, 'Cary Joji Fukunaga', 'Director'),
-- Other Movies
(26, 'Kirk Douglas', 'Actor'),
(26, 'Richard Fleischer', 'Director'),
(27, 'Spencer Tracy', 'Actor'),
(27, 'John Sturges', 'Director'),
(28, 'Liam Neeson', 'Actor'),
(28, 'Bille August', 'Director'),
(29, 'Spencer Tracy', 'Actor'),
(29, 'John Sturges', 'Director'),
(34, 'Sean Connery', 'Actor'),
(34, 'Jean-Jacques Annaud', 'Director'),
(35, 'Laurence Olivier', 'Actor'),
(35, 'Terence Young', 'Director'),
(36, 'Harrison Ford', 'Actor'),
(36, 'Guy Hamilton', 'Director'),
(37, 'Alec Guinness', 'Actor'),
(37, 'Lewis Gilbert', 'Director'),
-- Main star for TV shows
(30, 'Steve Bailey', 'Actor'), -- Alaska's Deadliest
(31, 'Jeremy Clarkson', 'Actor'), -- Clarkson's Farm
(32, 'Bill Nye', 'Actor'), -- Bill Nye the Science Guy
(33, 'David Attenborough', 'Actor'); -- Planet Earth

CREATE TABLE features_role (
    role_id INT AUTO_INCREMENT PRIMARY KEY,
    FK_work_id INT NOT NULL,
    character_name VARCHAR(100) NOT NULL,
    FOREIGN KEY (FK_work_id)
        REFERENCES feature_work (work_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO features_role (FK_work_id, character_name)
VALUES (1, 'James Bond'),
    (3, 'James Bond'),
    (5, 'James Bond'),
    (7, 'James Bond'),
    (9, 'James Bond'),
    (11, 'James Bond'),
    (13, 'James Bond'),
    (15, 'James Bond'),
    (17, 'James Bond'),
    (19, 'James Bond'),
    (21, 'James Bond'),
    (23, 'James Bond'),
    (25, 'James Bond'),
    (27, 'James Bond'),
    (29, 'James Bond'),
    (31, 'James Bond'),
    (33, 'James Bond'),
    (35, 'James Bond'),
    (37, 'James Bond'),
    (39, 'James Bond'),
    (41, 'James Bond'),
    (43, 'James Bond'),
    (45, 'James Bond'),
    (47, 'James Bond'),
    (49, 'James Bond'),
    (51, 'Ned Land'),
    (53, 'The Old Man'),
    (55, 'Jean Valjean'),
    (57, 'The Old Man'),
    (59, 'Narrator'),
    (60, 'Jeremy Clarkson'),
    (61, 'Bill Nye- Himself'),
    (62, 'Narrator'),
    (63, 'William of Baskerville'),
    (64, 'General Douglas MacArthur'),
    (65, 'Lieutenant Colonel Mike Barnsby'),
    (66, 'Captain Crawford');

-- Q1.
CREATE VIEW Bond_movies AS
SELECT fw1.person_name "person", fw1.work_type "job", COUNT(*) AS count
FROM feature_work fw1
inner join feature_work fw2 on fw1.FK_feature_id = fw2.FK_feature_id
inner join features_role fr 
where fw2.work_id = fr.FK_work_id and fr.character_name = "James Bond"
GROUP BY fw1.person_name, fw1.work_type
ORDER BY COUNT(*) DESC;
select * from Bond_movies;

-- Q2.
CREATE VIEW feature_work_together AS
SELECT f1.person_name "person1", f2.person_name "person2", COUNT(*) AS count
FROM feature_work f1, feature_work f2
WHERE f1.work_type = 'Actor' AND f2.work_type = 'Director'
	AND f1.FK_feature_id = f2.FK_feature_id
GROUP BY f1.person_name, f2.person_name 
ORDER BY COUNT(*) DESC;
select * from feature_work_together;

-- Q3.
CREATE VIEW bond_work_rate AS
SELECT fw1.person_name "person", fw1.work_type "job", 
	CONCAT(ROUND(100.0 * SUM(CASE WHEN fr.character_name = 'James Bond' THEN 1 ELSE 0 END) / COUNT(*), 0), '%') "percentage"
FROM feature_work fw1
inner join feature_work fw2 on fw1.FK_feature_id = fw2.FK_feature_id
inner join features_role fr 
where fw2.work_id = fr.FK_work_id
GROUP BY fw1.person_name, fw1.work_type
ORDER BY percentage DESC;
select * from bond_work_rate;

-- Q4.
CREATE VIEW actor_director_career AS
SELECT person1, person2, CONCAT(ROUND(fwt.count / b_movie1.count * 100), '%') "percent1",
						 CONCAT(ROUND(fwt.count / b_movie2.count * 100), '%') "percent2"
FROM feature_work_together fwt, bond_movies b_movie1, bond_movies b_movie2
WHERE fwt.person1 = b_movie1.person AND fwt.person2 = b_movie2.person
  AND b_movie1.job = 'Actor' AND b_movie2.job = 'Director';
select * from actor_director_career;