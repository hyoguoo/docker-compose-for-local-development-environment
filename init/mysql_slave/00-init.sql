CHANGE MASTER TO
    MASTER_HOST = 'mysql-master'
    , MASTER_USER = 'slave_user'
    , MASTER_PASSWORD = 'password'
    , MASTER_AUTO_POSITION = 1;

START SLAVE;
