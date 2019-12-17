#!/bin/bash
exec 3>myfile

echo "SELECT * FROM human_new" | psql >&3
pg_dump -d postgres > backup.dump

cd /var/lib/postgresql/
md5sum backup.dump > my* root@192.168.122.228:/var/lib/pgsql/backups
cd ~/
scp ./script.sh root@192.168.122.228:/var/lib/pgsql/backups
<< EOF
scp /var/lib/postgresql/backup.dump root@192.168.122.228:/var/lib/pgsql/backups 
EOF
ssh root@192.168.122.228 <<EOF
echo "DELETE FROM human_new" | sudo -u postgres psql
exec 2>myfile2
echo "SELECT * FROM human_new" | psql >&2
sudo -i -u postgres
psql postgres < backups/backup.dump
exit
cd /var/lib/pgsql/backups
md5sum backup.dump > myfiles_c.md5
md5sum myfiles_u.md5 myfiles_c.md5 > myfiles_final.md5
md5sum --check myfiles_final.md5
EOF
if [ $2 = $3 ]
then
        echo ok
else
        echo no
fi
