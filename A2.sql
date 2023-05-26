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

CREATE TABLE poker_values (
    card_id VARCHAR(3) NOT NULL PRIMARY KEY,
    game_value SMALLINT,
    FOREIGN KEY (card_id)
        REFERENCES standard_deck (id)
        ON DELETE CASCADE
);

insert into poker_values(card_id, game_value)
values ('1H', 14),
('2H', 2),
('3H', 3),
('4H', 4),
('5H', 5),
('6H', 6),
('7H', 7),
('8H', 8),
('9H', 9),
('10H', 10),
('JH', 11),
('QH', 12),
('KH', 13);
insert into poker_values(card_id, game_value)
values ('1C', 14),
('2C', 2),
('3C', 3),
('4C', 4),
('5C', 5),
('6C', 6),
('7C', 7),
('8C', 8),
('9C', 9),
('10C', 10),
('JC', 11),
('QC', 12),
('KC', 13);
insert into poker_values(card_id, game_value)
values ('1D', 14),
('2D', 2),
('3D', 3),
('4D', 4),
('5D', 5),
('6D', 6),
('7D', 7),
('8D', 8),
('9D', 9),
('10D', 10),
('JD', 11),
('QD', 12),
('KD', 13);
insert into poker_values(card_id, game_value)
values ('1S', 14),
('2S', 2),
('3S', 3),
('4S', 4),
('5S', 5),
('6S', 6),
('7S', 7),
('8S', 8),
('9S', 9),
('10S', 10),
('JS', 11),
('QS', 12),
('KS', 13);

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
(55, 24, 'KH'),
(55, 25, '2H'), 
(55, 25, '2S'), 
(55, 25, '3H'), 
(55, 25, '4S'), 
(55, 25, '3S'),
(55, 26, '2H'), 
(55, 26, '3S'), 
(55, 26, '3H'), 
(55, 26, '4S'), 
(55, 26, '4H'),
(55, 27, '9H'), 
(55, 27, '9S'), 
(55, 27, '5H'), 
(55, 27, '4S'), 
(55, 27, '4H'),
(55, 28, 'QH'), 
(55, 28, 'JS'), 
(55, 28, 'QS'), 
(55, 28, 'JH'), 
(55, 28, 'QD'),
(3, 28, '2H'), 
(3, 28, '3S'), 
(3, 28, '1S'), 
(3, 28, '5H'), 
(3, 28, '4D'),
(3, 29, 'JH'), 
(3, 29, 'KS'), 
(3, 29, '1S'), 
(3, 29, 'QH'), 
(3, 29, '10D');

create view ordered_hands as
SELECT DISTINCT h1.user_id "user_id", h1.game_id "game_id", h1.card_id "card_id1", h2.card_id "card_id2",
		h3.card_id "card_id3", h4.card_id "card_id4", h5.card_id "card_id5"
FROM poker_hands h1
INNER JOIN poker_values v1 ON v1.card_id = h1.card_id
INNER JOIN poker_hands h2 ON h1.user_id = h2.user_id AND h1.game_id = h2.game_id
INNER JOIN poker_values v2 ON v2.card_id = h2.card_id
INNER JOIN poker_hands h3 ON h1.user_id = h3.user_id AND h1.game_id = h3.game_id
INNER JOIN poker_values v3 ON v3.card_id = h3.card_id
INNER JOIN poker_hands h4 ON h1.user_id = h4.user_id AND h1.game_id = h4.game_id
INNER JOIN poker_values v4 ON v4.card_id = h4.card_id
INNER JOIN poker_hands h5 ON h1.user_id = h5.user_id AND h1.game_id = h5.game_id
INNER JOIN poker_values v5 ON v5.card_id = h5.card_id
WHERE (v1.game_value < v2.game_value or (v1.game_value = v2.game_value and h1.card_id < h2.card_id)) AND 
	  (v2.game_value < v3.game_value or (v2.game_value = v3.game_value and h2.card_id < h3.card_id)) AND 
	  (v3.game_value < v4.game_value or (v3.game_value = v4.game_value and h3.card_id < h4.card_id)) AND 
      (v4.game_value < v5.game_value or (v4.game_value = v5.game_value and h4.card_id < h5.card_id));

select * from ordered_hands;

-- Q1. FULL HOUSE
select user_id, game_id, card_id1, card_id2, card_id3, card_id4, card_id5 from ordered_hands
inner join poker_values v1 on v1.card_id = card_id1
inner join poker_values v2 on v2.card_id = card_id2
inner join poker_values v3 on v3.card_id = card_id3
inner join poker_values v4 on v4.card_id = card_id4
inner join poker_values v5 on v5.card_id = card_id5
where v1.game_value = v2.game_value and v4.game_value = v5.game_value and
	((v2.game_value = v3.game_value and v3.game_value < v4.game_value) or
	(v2.game_value < v3.game_value and v3.game_value = v4.game_value));

-- Q2. TWO PAIR
select user_id, game_id, card_id1, card_id2, card_id3, card_id4, card_id5 from ordered_hands
inner join poker_values v1 on v1.card_id = card_id1
inner join poker_values v2 on v2.card_id = card_id2
inner join poker_values v3 on v3.card_id = card_id3
inner join poker_values v4 on v4.card_id = card_id4
inner join poker_values v5 on v5.card_id = card_id5
where (v1.game_value <> v2.game_value and v2.game_value = v3.game_value and v3.game_value <> v4.game_value and v4.game_value = v5.game_value)
   or (v1.game_value = v2.game_value and v2.game_value <> v3.game_value and v3.game_value <> v4.game_value and v4.game_value = v5.game_value)
   or (v1.game_value = v2.game_value and v2.game_value <> v3.game_value and v3.game_value = v4.game_value and v4.game_value <> v5.game_value);

-- Q3. STRAIGHT
-- Same format as in the view (ordered_hands), the Aces are at the end of the row (card_id5)
select user_id, game_id, card_id1, card_id2, card_id3, card_id4, card_id5 from ordered_hands
inner join standard_deck d1 on d1.id = card_id1
inner join standard_deck d2 on d2.id = card_id2
inner join standard_deck d3 on d3.id = card_id3
inner join standard_deck d4 on d4.id = card_id4
inner join standard_deck d5 on d5.id = card_id5
where ((d1.card_rank = 2 and d2.card_rank = 3 and d3.card_rank = 4 and d4.card_rank = 5 and d5.card_rank = 1) 
    or (d1.card_rank = 10 and d2.card_rank = 11 and d3.card_rank = 12 and d4.card_rank = 13 and d5.card_rank = 1)
    or (d2.card_rank = d1.card_rank + 1 and d3.card_rank = d2.card_rank + 1 and d4.card_rank = d3.card_rank + 1 and d5.card_rank = d4.card_rank + 1))
    and not(d1.suit = d2.suit and d2.suit = d3.suit and d3.suit = d4.suit and d4.suit = d5.suit)