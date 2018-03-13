FROM mysql:5.6

ADD docs/change_log/testarena_db.sql /docker-entrypoint-initdb.d
