CREATE USER IF NOT EXISTS 'replicant'@'%' identified by 'password';

grant replication slave on *.* to replicant;

flush privileges;