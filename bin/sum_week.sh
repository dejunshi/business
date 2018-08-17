#sum_week.sh
#!/bin/bash
basepath=$(cd `/usr/bin/dirname "$0"`;/bin/pwd)
path=`/bin/echo $basepath | /bin/grep -oP "[\/0-9a-zA-Z]+(?=\/bin)"`
ability=`/bin/cat $path/conf/ability.cfg | /bin/grep -vE "#|^$"`
ability=(${ability//,/ })

#yesterday=`/bin/date -d yesterday +"%Y%m%d"`
today=`/bin/date -d today +"%Y%m%d"`

for d in `echo {1..7}`
do
  date=`/bin/date -d today +"%Y%m%d" --date "$d days ago"`
  /bin/cat $path/log/$date.log >> $path/log/$today.log_week && /bin/rm -rf $path/log/$date.log
done


for i in ${ability[@]}
do
  num=`/bin/cat $path/log/$today.log_week | grep -oP "(?<=$i:)[^ ]+" | xargs -n100000 | sed -r "s/ /+/g"`
  sum=$[$num]
  echo "DATE:$today  $i:$sum" >> $path/tmp/weblogic_sum.log
done
