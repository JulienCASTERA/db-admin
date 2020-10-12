CREATE DATABASE db_test;

USE db_test;

CREATE TABLE clients
(
    id INT NOT NULL
    AUTO_INCREMENT,
    lastName VARCHAR
    (255) NOT NULL,
    firstName VARCHAR
    (255) NOT NULL,
    zipCode CHAR
    (6),
    birthDate DATETIME NOT NULL,
    PRIMARY KEY
    (id)
);



    /* */

    INSERT INTO clients
        (firstName, lastName, zipCode, birthDate)
    VALUES
        ("chuck", "norris", "33000", "2011-01-01T15:03:01.012345"),
        ("test", "monblaz", "33200" , "2011-01-01T15:03:01.012345"),
        ("jean", "onch", "33290" , "2011-01-01T15:03:01.012345");


    SELECT firstName, zipCode
    FROM clients;