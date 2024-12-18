
create user 'mysql';
create user 'mysqld';

update mysql.user set password='PASSWORD' where user='root';
update mysql.user set password='PASSWORD' where user='mysql';
update mysql.user set password='PASSWORD' where user='mysqld';

grant all privileges on *.* to root;
grant all privileges on *.* to mysql;
grant all privileges on *.* to mysqld;

flush privileges;
