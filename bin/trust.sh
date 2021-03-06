#!/bin/bash

#batch configuration mutual trust
#author by djshi2
#ip.list file need have ip user and password

! which expect > /dev/null 2>&1 && echo "Please install expect first!" && exit 1

basepath=$(cd `/usr/bin/dirname "$0"`;/bin/pwd)
path=`/bin/echo $basepath | /bin/grep -oP "[\/0-9a-zA-Z]+(?=\/bin)"`

dir=`echo ~/.ssh`
cat $path/conf/ip.list | while read ip user password
do
  /usr/bin/expect << EOF
  spawn ssh-copy-id -i $dir/id_rsa $user@$ip
  expect {
          "yes/no" {send "yes\r";exp_continue}
          "assword" {send "$password\r"}
          timeout {puts "timeout on $ip";exit 1}
          }
  expect eof
EOF
done
