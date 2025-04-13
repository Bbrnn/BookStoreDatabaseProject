--Database to store bookstore data
CREATE DATABASE bookstoredb;

--SQL commmands to create tables 
CREATE TABLE book_language(
language_id INT PRIMARY KEY,
language VARCHAR(100)
);

CREATE TABLE publisher(
publisher_id INT PRIMARY KEY,
publisher_name VARCHAR(100)
);

CREATE TABLE books(
book_id INT PRIMARY KEY, 
title VARCHAR(200),
language_id INT, 
FOREIGN KEY (language_id) REFERENCES book_language(language_id), 
publisher_id INT, 
FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id)
isbn13 VARCHAR(13),
num_pages INT,
publication_date DATE
);

CREATE TABLE author(
author_id INT PRIMARY KEY,
author_name VARCHAR(100)
);

CREATE TABLE book_author (
book_id INT,
FOREIGN KEY (book_id) REFERENCES book (book_id),
author_id INT,
FOREIGN KEY (author_id) REFERENCES author(author_id)
);