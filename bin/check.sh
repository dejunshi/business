#check.sh
#!/bin/bash
basepath=$(cd `/usr/bin/dirname "$0"`;/bin/pwd)
path=`/bin/echo $basepath | /bin/grep -oP "[\/0-9a-zA-Z]+(?=\/bin)"`
ability=`/bin/cat $path/conf/ability.cfg | /bin/grep -vE "#|^$"`
yesterday=`/bin/date -d yesterday +"%Y%m%d"`

/bin/cat $path/conf/ip.list | while read ip user password
do
  /bin/cat $path/etc/weblogic | /usr/bin/ssh $user@$ip "/bin/cat > /tmp/weblogic;/bin/bash /tmp/weblogic $ability $ip;/bin/rm -rf /tmp/weblogic"
done >> $path/log/$yesterday.log
