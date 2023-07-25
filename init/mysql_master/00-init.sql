CREATE USER 'slave_user'@'%' identified BY 'password';
GRANT replication slave ON *.* TO 'slave_user'@'%' WITH GRANT OPTION;

flush PRIVILEGES;
