drop database if exists cards;
create database cards;
use cards;

CREATE TABLE standard_deck (
    id VARCHAR(3) NOT NULL PRIMARY KEY,
    position SMALLINT,
    suit VARCHAR(8),
    card_rank SMALLINT,
    type VARCHAR(6)
);

insert into standard_deck(id, position, suit, card_rank, type)
values ('1H', 1, 'Hearts', 1, 'number');
insert into standard_deck(id, position, suit, card_rank, type)
values ('2H', 2, 'Hearts', 2, 'number'),
('3H', 3, 'Hearts', 3, 'number'),
('4H', 4, 'Hearts', 4, 'number'),
('5H', 5, 'Hearts', 5, 'number'),
('6H', 6, 'Hearts', 6, 'number'),
('7H', 7, 'Hearts', 7, 'number'),
('8H', 8, 'Hearts', 8, 'number'),
('9H', 9, 'Hearts', 9, 'number'),
('10H', 10, 'Hearts', 10, 'number'),
('JH', 11, 'Hearts', 11, 'face'),
('QH', 12, 'Hearts', 12, 'face'),
('KH', 13, 'Hearts', 13, 'face');
insert into standard_deck(id, position, suit, card_rank, type)
values ('1C', 14, 'Clubs', 1, 'number'),
('2C', 15, 'Clubs', 2, 'number'),
('3C', 16, 'Clubs', 3, 'number'),
('4C', 17, 'Clubs', 4, 'number'),
('5C', 18, 'Clubs', 5, 'number'),
('6C', 19, 'Clubs', 6, 'number'),
('7C', 20, 'Clubs', 7, 'number'),
('8C', 21, 'Clubs', 8, 'number'),
('9C', 22, 'Clubs', 9, 'number'),
('10C', 23, 'Clubs', 10, 'number'),
('JC', 24, 'Clubs', 11, 'face'),
('QC', 25, 'Clubs', 12, 'face'),
('KC', 26, 'Clubs', 13, 'face');
insert into standard_deck(id, position, suit, card_rank, type)
values ('1D', 27, 'Diamonds', 1, 'number'),
('2D', 28, 'Diamonds', 2, 'number'),
('3D', 29, 'Diamonds', 3, 'number'),
('4D', 30, 'Diamonds', 4, 'number'),
('5D', 31, 'Diamonds', 5, 'number'),
('6D', 32, 'Diamonds', 6, 'number'),
('7D', 33, 'Diamonds', 7, 'number'),
('8D', 34, 'Diamonds', 8, 'number'),
('9D', 35, 'Diamonds', 9, 'number'),
('10D', 36, 'Diamonds', 10, 'number'),
('JD', 37, 'Diamonds', 11, 'face'),
('QD', 38, 'Diamonds', 12, 'face'),
('KD', 39, 'Diamonds', 13, 'face');
insert into standard_deck(id, position, suit, card_rank, type)
values ('1S', 40, 'Spades', 1, 'number'),
('2S', 41, 'Spades', 2, 'number'),
('3S', 42, 'Spades', 3, 'number'),
('4S', 43, 'Spades', 4, 'number'),
('5S', 44, 'Spades', 5, 'number'),
('6S', 45, 'Spades', 6, 'number'),
('7S', 46, 'Spades', 7, 'number'),
('8S', 47, 'Spades', 8, 'number'),
('9S', 48, 'Spades', 9, 'number'),
('10S', 49, 'Spades', 10, 'number'),
('JS', 50, 'Spades', 11, 'face'),
('QS', 51, 'Spades', 12, 'face'),
('KS', 52, 'Spades', 13, 'face');

CREATE TABLE users (
    user_id INT PRIMARY KEY
);
    
CREATE TABLE poker_hands (
    user_id INT,
    game_id INT NOT NULL,
    card_id VARCHAR(3) NOT NULL,
    FOREIGN KEY (user_id)
        REFERENCES users (user_id)
        ON DELETE CASCADE,
    FOREIGN KEY (card_id)
        REFERENCES standard_deck (id)
        ON DELETE CASCADE,
	UNIQUE (game_id, card_id)
);

insert into users(user_id)
values (1), (2), (3), (4), (55), (6), (7);

insert into poker_hands(user_id, game_id, card_id)
values (2, 3, '5S'), 
(2, 3, '5H'), 
(2, 3, '5D'), 
(2, 3, 'KH'), 
(2, 3, '10D'),
(1, 2, '7S'), 
(1, 2, '7H'), 
(1, 2, '7D'), 
(1, 2, '7C'), 
(1, 2, '10H'),
(1, 1, '2C'), 
(1, 1, '3C'), 
(1, 1, '4C'), 
(1, 1, '5C'), 
(1, 1, '6C'),
(3, 7, '10S'), 
(3, 7, 'KS'), 
(3, 7, '3H'), 
(3, 7, 'QD'), 
(3, 7, '9C'),
(3, 14, '10S'), 
(3, 14, 'JS'), 
(3, 14, 'QS'), 
(3, 14, 'KS'), 
(3, 14, '1S'),
(3, 15, 'JS'), 
(3, 15, 'QS'), 
(3, 15, 'KS'), 
(3, 15, '1S'), 
(3, 15, '2S'),
(3, 16, '1S'), 
(3, 16, '2S'), 
(3, 16, '3S'), 
(3, 16, '4S'), 
(3, 16, '5S'),
(55, 10, 'KH'), 
(55, 10, 'KS'), 
(55, 10, 'KC'), 
(55, 10, '1S'), 
(55, 10, '1H'),
(55, 11, '2H'), 
(55, 11, '6H'), 
(55, 11, '8H'), 
(55, 11, 'JH'), 
(55, 11, 'QH'),
(55, 24, '9H'), 
(55, 24, '10S'), 
(55, 24, 'JH'), 
(55, 24, 'QS'), 
(55, 24, 'KH');
   
-- Q1. FOUR-OF-A-KIND
SELECT DISTINCT h1.user_id, h1.game_id, h1.card_id, h2.card_id, h3.card_id, h4.card_id, h5.card_id
FROM poker_hands h1
INNER JOIN standard_deck d1 ON h1.card_id = d1.id
INNER JOIN poker_hands h2 ON h1.user_id = h2.user_id AND h1.game_id = h2.game_id
INNER JOIN standard_deck d2 ON h2.card_id = d2.id AND d1.card_rank = d2.card_rank
INNER JOIN poker_hands h3 ON h1.user_id = h3.user_id AND h1.game_id = h3.game_id
INNER JOIN standard_deck d3 ON h3.card_id = d3.id AND d1.card_rank = d3.card_rank
INNER JOIN poker_hands h4 ON h1.user_id = h4.user_id AND h1.game_id = h4.game_id
INNER JOIN standard_deck d4 ON h4.card_id = d4.id AND d1.card_rank = d4.card_rank
INNER JOIN poker_hands h5 ON h1.user_id = h5.user_id AND h1.game_id = h5.game_id
INNER JOIN standard_deck d5 ON h5.card_id = d5.id AND d1.card_rank <> d5.card_rank
WHERE h1.card_id < h2.card_id AND h2.card_id < h3.card_id AND h3.card_id < h4.card_id;

-- Q2. THREE-OF-A-KIND
SELECT DISTINCT h1.user_id, h1.game_id, h1.card_id, h2.card_id, h3.card_id, h4.card_id, h5.card_id
FROM poker_hands h1
INNER JOIN standard_deck d1 ON h1.card_id = d1.id
INNER JOIN poker_hands h2 ON h1.user_id = h2.user_id AND h1.game_id = h2.game_id
INNER JOIN standard_deck d2 ON h2.card_id = d2.id AND d1.card_rank = d2.card_rank
INNER JOIN poker_hands h3 ON h1.user_id = h3.user_id AND h1.game_id = h3.game_id
INNER JOIN standard_deck d3 ON h3.card_id = d3.id AND d1.card_rank = d3.card_rank
INNER JOIN poker_hands h4 ON h1.user_id = h4.user_id AND h1.game_id = h4.game_id
INNER JOIN standard_deck d4 ON h4.card_id = d4.id AND d1.card_rank <> d4.card_rank
INNER JOIN poker_hands h5 ON h1.user_id = h5.user_id AND h1.game_id = h5.game_id
INNER JOIN standard_deck d5 ON h5.card_id = d5.id AND d1.card_rank <> d5.card_rank
	AND d4.card_rank <> d5.card_rank -- considering (2D, 2H, 2C, 3S, 3C) as FULL-HOUSE, !THREE-OF-A-KIND
WHERE h1.card_id < h2.card_id AND h2.card_id < h3.card_id AND h4.card_id < h5.card_id;

-- Q3. STRAIGHT FLUSHES
SELECT DISTINCT h1.user_id, h1.game_id, h1.card_id, h2.card_id, h3.card_id, h4.card_id, h5.card_id
FROM poker_hands h1
INNER JOIN standard_deck d1 ON h1.card_id = d1.id
INNER JOIN poker_hands h2 ON h1.user_id = h2.user_id AND h1.game_id = h2.game_id
INNER JOIN standard_deck d2 ON h2.card_id = d2.id AND d1.suit = d2.suit AND d2.card_rank = d1.card_rank + 1
INNER JOIN poker_hands h3 ON h1.user_id = h3.user_id AND h1.game_id = h3.game_id
INNER JOIN standard_deck d3 ON h3.card_id = d3.id AND d1.suit = d3.suit AND d3.card_rank = d2.card_rank + 1
INNER JOIN poker_hands h4 ON h1.user_id = h4.user_id AND h1.game_id = h4.game_id
INNER JOIN standard_deck d4 ON h4.card_id = d4.id AND d1.suit = d4.suit AND d4.card_rank = d3.card_rank + 1
INNER JOIN poker_hands h5 ON h1.user_id = h5.user_id AND h1.game_id = h5.game_id
INNER JOIN standard_deck d5 ON h5.card_id = d5.id AND d1.suit = d5.suit 
	AND (d5.card_rank = d4.card_rank + 1 OR (d4.card_rank = 13 AND d5.card_rank = 1));