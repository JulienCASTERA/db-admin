/* COMMON PART AS ROOT */

CREATE DATABASE IF NOT EXISTS events;

USE events;

CREATE TABLE IF NOT EXISTS public_events(
  event_date DATE NOT NULL,
  event_name VARCHAR(255) NOT NULL,
  event_age_requirement INT NOT NULL
);

CREATE TABLE IF NOT EXISTS private_events LIKE public_events;

GRANT ALL
    ON events.*
    TO 'event_manager'@'%'
    IDENTIFIED BY "password";

GRANT SELECT
    ON events.public_events
    TO 'event_supervisor'@'%'
    IDENTIFIED BY "password";

FLUSH PRIVILEGES ;


/* EVENT MANAGER PART */

use events;

INSERT INTO public_events
    VALUES ("2003-12-31", "Event1Public", 18),
           ("2005-10-28", "Event2Public", 14),
           ("2008-4-13", "Event3Public", 69);

INSERT INTO private_events
    VALUES ("2003-12-31", "Event1Private", 18),
           ("2005-10-28", "Event2Private", 14),
           ("2008-4-13", "Event3Private", 69);

/* EVENT SUPERVISOR PART */

use events;

SELECT * FROM public_events;

SELECT * FROM private_events;

mysql> SELECT * FROM public_events;
+------------+--------------+-----------------------+
| event_date | event_name   | event_age_requirement |
+------------+--------------+-----------------------+
| 2003-12-31 | Event1Public |                    18 |
| 2005-10-28 | Event2Public |                    14 |
| 2008-04-13 | Event3Public |                    69 |
+------------+--------------+-----------------------+
3 rows in set (0.00 sec)

mysql>
mysql> SELECT * FROM private_events;
ERROR 1142 (42000): SELECT command denied to user 'event_supervisor'@'localhost' for table 'private_events'

/* ROOT PART */

DROP USER 'event_supervisor'@'%';