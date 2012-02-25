#!/bin/sh

dir="/spool/backup";
backup_rotate () {
mv $dir/$name.4.gz $dir/$name.5.gz
mv $dir/$name.3.gz $dir/$name.4.gz
mv $dir/$name.2.gz $dir/$name.3.gz
mv $dir/$name.1.gz $dir/$name.2.gz
mv $dir/$name.gz   $dir/$name.1.gz
}

databases="bs_shedule"
for db in $databases; do
	name="mysql.${db}.backup";
	backup_rotate
	/usr/local/bin/mysqldump --quick ${db} | gzip > $dir/$name.gz
done
