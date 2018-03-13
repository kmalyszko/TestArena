FROM mysql:5.6

ADD docs/change_log/testarena_db.sql /docker-entrypoint-initdb.d

### right now, it does not work as advertised in official MySQL images description.
### no data import from docker-entrypoint-initdb.d directory
### spell to manually seed the database ::
### docker exec <CONTAINER ID OR NAME> /usr/bin/mysqldump -u root --password=<root password> <DATABASE_NAME> > backup_or_dump_file_name_and_path.sql
