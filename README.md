# vdvas_infra
cloud-bastion
vdvas Infra repository

Homework 3 OVPN
```
bastion_IP = 35.195.200.220
someinternalhost_IP = 10.132.0.3
```


Homework 3 Bastion host and SSH
=======
vdvas Infra repository  

```
bastion_IP = 35.195.200.220
someinternalhost_IP = 10.132.0.3
```

Подключение в одну строку к someinternalhost командой
```
ssh someinternalhost
```
Я использую под Windows git ssh клиент Git Bash.  
Настроить MINGW64 на автозапуск ssh-agent при запуске клиента.
```
    eval $(ssh-agent -s)
    ssh-add ~/.ssh/GCP/appuser
```

В папке пользователя в папке .ssh создать файл config:
```
Host someinternalhost
         HostName 10.132.0.3
         User appuser
         ProxyCommand ssh -W %h:%p  appuser@35.195.200.220
```
После этого подключение будет работать в одну строку.
     
```     
Agent pid 15596
Identity added: .ssh/GCP/appuser (appuser)

Äìèòðèé@DESKTOP-D3E66QS MINGW64 ~
$ ssh someinternalhost
Welcome to Ubuntu 16.04.5 LTS (GNU/Linux 4.15.0-1025-gcp x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  Get cloud support with Ubuntu Advantage Cloud Guest:
    http://www.ubuntu.com/business/services/cloud

0 packages can be updated.
0 updates are security updates.


Last login: Wed Feb  6 20:08:15 2019 from 10.132.0.2
appuser@someinternalhost:~$ hostname
someinternalhost
appuser@someinternalhost:~$ ip address
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: ens4: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1460 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 42:01:0a:84:00:03 brd ff:ff:ff:ff:ff:ff
    inet 10.132.0.3/32 brd 10.132.0.3 scope global ens4
       valid_lft forever preferred_lft forever
    inet6 fe80::4001:aff:fe84:3/64 scope link
       valid_lft forever preferred_lft forever
appuser@someinternalhost:~$
```

