#Homework 6
Packer-base

Был скачал packer с оцифиального сайта.  
Предоставлен доступ к gcloud.  
`$ gcloud auth application-default login`  
Был создан шаблон ubuntu16.json  
В шаблон были добавлены провижинеры для установки приложений.  
Проверка корректности шаблона  
`$ packer validate ./ubuntu16.json`  
Запуск билда образа  
`$ packer build ubuntu16.json`  
Создадим ВМ из созданного образа и подключися к вм  
`$ ssh appuser@<instace_public_ip>`  
Установим приложение, используя следующие команды  
```
$ git clone -b monolith https://github.com/express42/reddit.git
$ cd reddit && bundle install
$ puma -d
```
Вынесем пеерменные в отдельный файл variables.  
Отредактируем шаблон, внеся переменные.  

Команда для создания вм из образа  
```
gcloud compute instances create reddit-from-image1 \
--image reddit-base-1552944958 \
--image-family reddit-full \
--restart-on-failure \
```

#Homework 5

Config description:
```
testapp_IP=35.204.33.101
testapp_port=9292
```

Скрипты , находящиеся в репозитории.
- install_ruby.sh - установка ruby
- install_mongodb.sh - установка mongodb
- deploy.sh - установка зависимостей.
- install.sh - объединенные 3 скрипта выше в одну команду для указания gcloud как аргумент ключа metadata-from-file.

Команда для создания инстанса и запуска скрипта по установке ruby, mongod и запуску puma.
```
gcloud compute instances create reddit-app \
--boot-disk-size=10GB \
--image-family ubuntu-1604-lts \
--image-project=ubuntu-os-cloud \
--machine-type=g1-small \
--tags puma-server  \
--zone europe-west4-a  \
--restart-on-failure \
--metadata-from-file startup-script=install.sh
```


Команда gcloud, которая создает правило брандмауэра, разрешающее соединения на порт 9292 по протоколу TCP.
```
gcloud compute firewall-rules create allow-9292-tcp-in --allow=TCP:9292
```




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




