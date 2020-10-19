# MariaDB - Replication

## Configuration

Pour ce TP, on va utiliser 2 conteneurs mariadb, l'un sera accessible en écriture et lecture, on dit qu'il s'appelle "Master".

(cf: docker-compose.yml)

Le deuxième, "Slave" sera juste accessible en lecture et aura pour but de simplement répliquer les données de "Master".

Bien sûr, les deux conteneurs seront connectés au même réseau interne de docker.

### Master

Au niveau de Master on a juste besoin de dire à mariadb de commencer la réplication, et que cette machine sera la machine maitre.

````conf
# /etc/mysql/mariadb.conf.d/master.cnf

[mariadb]
log-bin
server_id=1
log-basename=master1
binlog-format=mixed
````


Ensuite, on va créer un utilisateur autorisé à faire de la réplication.


````sql
CREATE USER IF NOT EXISTS 'replicant'@'%' identified by 'password';

grant replication slave on *.* to replicant;

flush privileges;
````

#### Slave

La configuration au niveau de mariadb se fait aussi, mais de manière plus simple, on a juste à définir l'ID du serveur.


````conf
# /etc/mysql/mariadb.conf.d/slave.cnf

[mariadb]
server_id=2
````

Ensuite, on va ajouter l'état "Slave" en se connectant au "Master"

````sql
CHANGE MASTER TO
MASTER_HOST='master-replication.localhost',
MASTER_USER='replicant',
MASTER_PASSWORD='password',
MASTER_PORT=3306,
MASTER_LOG_FILE='master1-bin.000003',
MASTER_LOG_POS=344,
MASTER_CONNECT_RETRY=10;

START SLAVE;
````

Attention, `MASTER_LOG_FILE='master1-bin.000003'`, il faut bien faire attention à cette ligne et modifier le bon binaire correspondant (Utiliser la commande `SHOW MASTER STATUS;` sur le Master ...)

On peut vérifier le status de la configuration du Slave avec `SHOW SLAVE STATUS;` mais si tout est bien configuré, en regardant les tables dans notre base de données on devrait apercevoir qu'elles ont apparues sur le slave.


On peut aussi tester d'écrire sur le Master pour observer si cela se fait bien en temps "réel".
