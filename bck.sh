#! /bin/bash
TIMESTAMP=$(date +"%d%m%Y_%H%M")  
BACKUP_DIR="/databases/$TIMESTAMP" #caminho aonde sera salvo os arquivos 
MYSQL_USER="root" # Usuario
MYSQL=/usr/bin/mysql
MYSQL_PASSWORD="root" # Senha
MYSQLDUMP=/usr/bin/mysqldump
HOST="127.0.0.1" #Troque de acordo com local aonde seu DB esteja hospedado 
PORT="3306"   #Porta padrão mude caso necessite
EXCLUDES="Database|information_schema|performance_schema"  # Aqui estão as base de dado que não entrara no backup


mkdir -p "$BACKUP_DIR"
databases=`$MYSQL    --user=$MYSQL_USER -p$MYSQL_PASSWORD -h $HOST --port $PORT  -e "SHOW DATABASES;" | grep -Ev "($EXCLUDES)"`

for db in $databases; do
  $MYSQLDUMP  -h  $HOST  --port $PORT --force --opt --lock-tables=0 --user=$MYSQL_USER -p$MYSQL_PASSWORD  --databases  $db   > "$BACKUP_DIR/$db.sql"
done