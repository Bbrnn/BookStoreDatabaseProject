CREATE DATABASE BookStoreDB;
USE BookStoreDB;

CREATE TABLE book_language (
    language_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE publisher (
    publisher_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE author (
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL
);

CREATE TABLE country (
    country_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE address_status (
    status_id INT PRIMARY KEY AUTO_INCREMENT,
    status_name VARCHAR(50) NOT NULL
);

CREATE TABLE shipping_method (
    shipping_id INT PRIMARY KEY AUTO_INCREMENT,
    method_name VARCHAR(100) NOT NULL
);

CREATE TABLE order_status (
    status_id INT PRIMARY KEY AUTO_INCREMENT,
    status_name VARCHAR(50) NOT NULL
);

CREATE TABLE book (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    publisher_id INT,
    language_id INT,
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id),
    FOREIGN KEY (language_id) REFERENCES book_language(language_id)
);

CREATE TABLE book_author (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (author_id) REFERENCES author(author_id)
);

CREATE TABLE customer (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE
);

CREATE TABLE address (
    address_id INT PRIMARY KEY AUTO_INCREMENT,
    line1 VARCHAR(255),
    country_id INT,
    FOREIGN KEY (country_id) REFERENCES country(country_id)
);

CREATE TABLE customer_address (
    customer_id INT,
    address_id INT,
    status_id INT,
    PRIMARY KEY (customer_id, address_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (address_id) REFERENCES address(address_id),
    FOREIGN KEY (status_id) REFERENCES address_status(status_id)
);

CREATE TABLE cust_order (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    shipping_id INT,
    status_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (shipping_id) REFERENCES shipping_method(shipping_id),
    FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);

CREATE TABLE order_line (
    order_id INT,
    book_id INT,
    quantity INT,
    PRIMARY KEY (order_id, book_id),
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);

CREATE TABLE order_history (
    history_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    status_id INT,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);










-- 1. book_language
INSERT INTO book_language (name) VALUES
('English'), ('French'), ('Spanish'), ('German'), ('Chinese'),
('Swahili'), ('Arabic'), ('Hindi'), ('Russian'), ('Portuguese');

-- 2. publisher
INSERT INTO publisher (name) VALUES
('Penguin'), ('HarperCollins'), ('Simon & Schuster'), ('Hachette'), ('Macmillan'),
('Scholastic'), ('Oxford Press'), ('Pearson'), ('Springer'), ('Cambridge Press');

-- 3. author
INSERT INTO author (full_name) VALUES
('George Orwell'), ('J.K. Rowling'), ('Jane Austen'), ('Mark Twain'),
('Stephen King'), ('Leo Tolstoy'), ('Chinua Achebe'), ('Ngugi wa Thiong\'o'),
('J.R.R. Tolkien'), ('Haruki Murakami');

-- 4. country
INSERT INTO country (name) VALUES
('USA'), ('UK'), ('France'), ('Germany'), ('China'),
('Kenya'), ('India'), ('Brazil'), ('Russia'), ('Canada');

-- 5. address_status
INSERT INTO address_status (status_name) VALUES
('Current'), ('Old'), ('Temporary'), ('Permanent'), ('Billing'),
('Shipping'), ('Primary'), ('Secondary'), ('Vacation'), ('Work');

-- 6. shipping_method
INSERT INTO shipping_method (method_name) VALUES
('Standard'), ('Express'), ('Overnight'), ('Two-Day'), ('Drone'),
('In-Store Pickup'), ('Locker Pickup'), ('International'), ('Economy'), ('Courier');

-- 7. order_status
INSERT INTO order_status (status_name) VALUES
('Pending'), ('Shipped'), ('Delivered'), ('Cancelled'), ('Returned'),
('Processing'), ('On Hold'), ('Out for Delivery'), ('Failed'), ('Completed');

-- 8. book
INSERT INTO book (title, language_id, publisher_id, price) VALUES
('1984', 1, 1, 12.99), ('Harry Potter', 1, 2, 15.99), ('Pride and Prejudice', 1, 3, 10.99),
('Adventures of Huckleberry Finn', 1, 4, 11.50), ('The Shining', 1, 5, 14.00),
('War and Peace', 1, 6, 13.25), ('Things Fall Apart', 6, 7, 9.75),
('The River Between', 6, 8, 9.99), ('The Hobbit', 1, 9, 16.50), ('Kafka on the Shore', 1, 10, 12.75);

-- 9. book_author
INSERT INTO book_author (book_id, author_id) VALUES
(1,1), (2,2), (3,3), (4,4), (5,5),
(6,6), (7,7), (8,8), (9,9), (10,10);

-- 10. customer
INSERT  IGNORE INTO customer (name, email) VALUES
('Alice Smith', 'alice@example.com'),
('Bob Johnson', 'bob@example.com'),
('Carol Williams', 'carol@example.com'),
('David Brown', 'david@example.com'),
('Eve Jones', 'eve@example.com'),
('Frank Garcia', 'frank@example.com'),
('Grace Martinez', 'grace@example.com'),
('Heidi Davis', 'heidi@example.com'),
('Ivan Lopez', 'ivan@example.com'),
('Judy Wilson', 'judy@example.com');


-- 11. address
INSERT INTO address (street, city, postal_code, country_id) VALUES
('123 Main St', 'New York', '10001', 1), ('456 Elm St', 'London', 'SW1A 1AA', 2),
('789 Oak St', 'Paris', '75001', 3), ('321 Pine St', 'Berlin', '10115', 4),
('654 Maple St', 'Beijing', '100000', 5), ('147 Cypress St', 'Nairobi', '00100', 6),
('258 Birch St', 'Mumbai', '400001', 7), ('369 Cedar St', 'Rio', '20000-000', 8),
('741 Spruce St', 'Moscow', '101000', 9), ('852 Palm St', 'Toronto', 'M5H 2N2', 10);

INSERT INTO address (line1, country_id) VALUES
('123 Main St', 1),
('456 Elm St', 2),
('789 Oak St', 3),
('321 Pine St', 4),
('654 Maple St', 5),
('147 Cypress St', 6),
('258 Birch St', 7),
('369 Cedar St', 8),
('741 Spruce St', 9),
('852 Palm St', 10);


-- 13. cust_order
INSERT INTO customer_address (customer_id, address_id, status_id) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 2),
(4, 4, 1),
(5, 5, 2),
(6, 6, 1),
(7, 7, 1),
(8, 8, 1),
(9, 9, 2),
(10, 10, 1);


-- 14. order_line
INSERT INTO cust_order (customer_id, shipping_id, status_id) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 1),
(4, 1, 3),
(5, 2, 2),
(6, 3, 1),
(7, 1, 2),
(8, 2, 3),
(9, 3, 1),
(10, 1, 1);


-- 15. order_history
INSERT INTO order_history (order_id, status_id) VALUES
(1, 1),  -- For order 1, status 1 (e.g., Order placed)
(1, 2),  -- For order 1, status 2 (e.g., Order shipped)
(2, 1),  -- For order 2, status 1 (e.g., Order placed)
(2, 3),  -- For order 2, status 3 (e.g., Order delivered)
(3, 2),  -- For order 3, status 2 (e.g., Order shipped)
(4, 1),  -- For order 4, status 1 (e.g., Order placed)
(4, 3),  -- For order 4, status 3 (e.g., Order delivered)
(5, 1),  -- For order 5, status 1 (e.g., Order placed)
(6, 2),  -- For order 6, status 2 (e.g., Order shipped)
(7, 1);  -- For order 7, status 1 (e.g., Order placed)
