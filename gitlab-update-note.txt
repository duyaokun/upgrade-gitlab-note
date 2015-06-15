# backup
*installdir* : `gitlab-6.9.2.-1`

* Change to the directory in which you wish to save your backup.

	> cd /your/directory

* Stop all servers.

	> $ sudo *installdir*/ctlscript.sh stop
* Create a compressed file with the stack contents.

	> $ sudo tar -pczvf application-backup.tar.gz *installdir*
* Restart all servers.

	> $ sudo *installdir*/ctlscript.sh start
