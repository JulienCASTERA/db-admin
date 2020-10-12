# Migration MYSQL -> MariaDB

cf: https://courses.codebuds.com/Database-Administration#/17/3


Sur MYSQL : 

```sql

CREATE DATABASE migration;
CREATE TABLE users(
    id INT NOT NULL AUTO_INCREMENT,
    firstName VARCHAR(255) NOT NULL,
    lastName VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
);

INSERT INTO users
(firstName, lastName, email)
VALUES
('Julien','Castera','julien.castera@ynov.com');


mysqldump -u root -p migration > /backups/backup.sql
```

Sur MariaDB :

```sql
CREATE DATABASE migrationbackup;
exit

------

mysql -u root -p migrationbackup < /backups/backup.sql ;

```