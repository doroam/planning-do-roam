#!/bin/bash
# bbou@ac-toulouse;fr
# 21.02.2009 

db='bremen'
dbtype=postgresql
dbuser=openstreetmap
dbdelete=
if [ "$1" == "-d" ]; then
dbdelete=true
fi
modules="wn legacy vn xwn bnc sumo"

function process()
{
	if [ ! -e "$1" ];then
		return
	fi
	echo "$2"
	psql -h localhost -U ${dbuser} -f $1 $3
}

function dbexists()
{
	psql -h localhost -U ${dbuser} -c "\q" ${db} > /dev/null 2> /dev/null
	return $?
}

function deletedb()
{
	echo "delete ${db}"
	psql -h localhost -U ${dbuser} -c "DROP DATABASE ${db};" template1
}

function createdb()
{
	echo "create ${db}"
	psql -h localhost -U ${dbuser} -c "CREATE DATABASE ${db} WITH TEMPLATE = template0 ENCODING = 'UTF8';" template1
}

function getpassword()
{
	read -s -p "enter ${dbuser}'s password: " PGPASSWORD
	echo
}

echo "restoring ${db}"
getpassword

#database
#if [ ! -z ${dbdelete} ]; then
#	deletedb
#fi
if ! dbexists; then
	createdb
fi

module tables
for m in ${modules}; do
	sql=${dbtype}-${m}-schema.sql
	process ${sql} schema ${db}
done
for m in ${modules}; do
        sql=${dbtype}-${m}-data.sql
	process ${sql} data ${db}
done
for m in ${modules}; do
	sql=${dbtype}-${m}-constraints.sql
	process ${sql} constraints ${db} --force
done
for m in ${modules}; do
	sql=${dbtype}-${m}-views.sql
	process ${sql} views ${db}
done

