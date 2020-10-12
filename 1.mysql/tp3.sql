/** ROOT COMMANDS SCRIPT */

CREATE DATABASE IF NOT EXISTS teams;

USE teams;

CREATE TABLE IF NOT EXISTS games(
  id INT NOT NULL AUTO_INCREMENT,
  match_date DATETIME NOT NULL,
  victory BOOLEAN NOT NULL,
  observations TEXT,
  PRIMARY KEY(id)
);

CREATE TABLE IF NOT EXISTS players(
    id INT NOT NULL AUTO_INCREMENT,
    firstname VARCHAR(255) NOT NULL,
    lastname VARCHAR(255) NOT NULL,
    start_date DATE NOT NULL,
    PRIMARY KEY(id)
);

GRANT ALL
    ON teams.*
    TO 'manager'@'localhost'
    IDENTIFIED BY "manager_password";

GRANT SELECT, INSERT
    ON teams.players
    TO 'recruiter'@'localhost'
    IDENTIFIED BY "recruiter_password";

FLUSH PRIVILEGES;

/*
    LE FICHIER EST CREE rootcommands.sql EST CREE
    DANS LE DOCKER VIA VIM...

    ENSUITE,
    ON EXECUTE CA VIA LA COMMANDE
    mysql -u root -p < rootcommands.sql
 */


/*
    ON CREE managercommands.sql VIA VIM
    MANAGER SCRIPT
    mysql -u manager -p < managercommands.sql
*/

USE teams;

TRUNCATE games;

INSERT INTO games (match_date, victory, observations)
    VALUES ("2011-01-01T15:03:01.012345", "1", "Beau match !"),
           ("2011-01-01T15:03:01.012345", "0", "Beau combat"),
           ("2011-01-01T15:03:01.012345", "1", "OBSERVATION :)")
           ;
