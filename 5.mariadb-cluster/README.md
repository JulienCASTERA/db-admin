# Mariadb Clusters

## Installation

Pour créer un cluster de 3 nodes, on va devoir faire de la config.

Dans notre `docker-compose.yml`, pour le premier node il va falloir override la commande de démarrage de mariadb.

On rajoute donc : `command: --wsrep-new-cluster`

Pour tous les nodes il va falloir mettre sur les containers cette config dans `/etc/mysql/conf.d/galera.cnf` et changer le node name pour chaque conteneur.

````conf
[mysqld]
wsrep_node_address="first.localhost"

# cette ligne à modifier pour les autres containers
wsrep_node_name="node1"
wsrep_cluster_address="gcomm://first.localhost,second.localhost,third.localhost"

wsrep_provider=/usr/lib/libgalera_smm.so
binlog_format=ROW
default_storage_engine=InnoDB
innodb_autoinc_lock_mode=2
innodb_doublewrite=1
query_cache_size=0
wsrep_on=ON
````


Pour démarrer le cluster il faut utiliser une ristourne et bind le fichier `/var/lib/mysql/grastate.dat` du premier container.

````conf
# GALERA saved state
version: 2.1
uuid:    1664c21c-1217-11eb-8160-0ecd0cb2593d
seqno:   -1

# cette valeur doit être mise à 1 avant chaque démarrage
safe_to_bootstrap: 1
````

Les noeuds vont se connecter entre eux.

On peut vérifier :

````
MariaDB [ok]> SHOW GLOBAL STATUS LIKE 'wsrep_cluster_size';
+--------------------+-------+
| Variable_name      | Value |
+--------------------+-------+
| wsrep_cluster_size | 3     |
+--------------------+-------+
1 row in set (0.001 sec)

MariaDB [ok]> 
````