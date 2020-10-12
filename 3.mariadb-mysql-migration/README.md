# Migration MYSQL -> MariaDB

cf: https://courses.codebuds.com/Database-Administration#/17/3


Sur MYSQL : 

```sql

mysql -u root -p

CREATE DATABASE migration;
use migration;
CREATE TABLE users(
    id INT NOT NULL AUTO_INCREMENT,
    firstName VARCHAR(255) NOT NULL,
    lastName VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    PRIMARY KEY(id)
);

INSERT INTO users
(firstName, lastName, email)
VALUES
('Julien','Castera','julien.castera@ynov.com');
exit;

mysqldump -u root -p migration > /backups/backup.sql
```

Sur MariaDB :

```sql

mysql -u root -p


CREATE DATABASE migrationbackup;
exit;

------

mysql -u root -p migrationbackup < /backups/backup.sql ;

```