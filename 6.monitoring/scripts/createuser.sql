CREATE USER 'mysqld_exporter'@'%' IDENTIFIED BY 'passwordExporter';

GRANT PROCESS, REPLICATION CLIENT SELECT ON *.* TO 'mysqld_exporter'@'%';
FLUSH PRIVILEGES;
EXIT