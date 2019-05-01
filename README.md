#Homework 10  
Ansible-2  


Создадим плейбук reddit_app.yml  
В нем, при помощи модуля template скопируем заранее заготовленный конфиг mongodb на хост.  
Заготовленный конфиг будет находится в директории templates  
Определим значения переменных в нашем плейбуке.
```
vars:
  mongo_bind_ip: 0.0.0.0
```
Пробный прогон  
`ansible-playbook reddit_app.yml --check --limit db`  
Добавим хендлер для рестарта службы mongodb.  
Применим плейбук  
` ansible-playbook reddit_app.yml --limit db`  
Используя модуль copy в нашем плейбуке, скопируем заранее заготовленный  файл systemd puma.  
Модуль systemd для включения автозапуска сервиса puma.  
Добавим хендлер для перезапуска puma.  
Создадим шаблон в директории templates/db_config.j2, который содержит присвоение переменной DATABASE_URL, которое мы передаем ансиблом через переменную db_host.  
Добавим таск для копирования созданного шаблона.  
Определим переменную db_host в плейбуке.  
Теперь можно применить плейбук.  
Добавим закачивание кода при помощи модуля git и установку зависимостей модулем bundler.  
  
Создадим новый файл reddit_app2.yml  
Скопируем определение сценария из reddit_app.yml и всю информацию, относящуюся к настройке MongoDB.  
Аналогичным образом определим еще один сценарий для настройки инстанса приложения.
Вынесем плейбуки для puma и mongo в файлы app.yml и db.yml соответственно.  
Создадим файл deploy.yml в котором опишем скачивание git'ом приложения.  
Заодно переименуем наши предыдущие плейбуки: 
reddit_app.yml ➡ reddit_app_one_play.yml  
reddit_app2.yml ➡ reddit_app_multiple_plays.yml  
Создадим файл site.yml который будет включать в себя все остальные.  
```
---
- import_playbook: db.yml
- import_playbook: app.yml
- import_playbook: deploy.yml
```
  
Изменим provision в Packer и заменим bash скрипты на Ansible-плейбуки.  
Создадим на основе созданных плейбуков плейбуки для пакера.  
ansible/packer_app.yml и ansible/packer_db.yml.  


#Homework 9  
Ansible-1  
Создадим инвентори файл ansible/inventory  
`appserver ansible_host=35.195.186.154 ansible_user=appuser ansible_private_key_file=~/.ssh/appuser`  
Используем команду ansible для вызова модуля ping из командной строки.  
`ansible appserver -i ./inventory -m ping`  
Повторите такую же процедуру для инстанса БД.  
Определим некоторые параметры в файле ansible.cfg.  
Теперь мы можем удалить избыточную информацию из файла inventory.  
Выполним команду uptime `ansible dbserver -m command -a uptime`  
Определим группы хостов в инвентори файле.  
Создадим файл inventory.yml и перенесем в него записи из имеющегося inventory.  
Используем модуль shell для проверки установки необходимых пакетов.  
`ansible app -m shell -a 'ruby -v; bundler -v'`  
Используем модуль systemd для проверки работы службы mongo.  
`ansible db -m systemd -a name=mongod`  
Сравним выполнение скачивания репозитория гита при помощи модуля git и command. Сравним вывод команд.  
СОздадим плейбук ansible/clone.yml и выполним его `ansible-playbook clone.yml`  


#Homework 8  
Terraform-2  
  
Создадим ресурс правила фаервола SSH в main.tf.  Применим конфигурацию и получим ошибку, из-за того что правило уже существует.  
Занесем в state terraform информацию о существуюшем правиле фаервола.  
`$ terraform import google_compute_firewall.firewall_ssh default-allow-ssh`  
Зададим IP для инстанса в main.tf  
Внутри конфигурации ВМ определим IP адрес.  
Вынесем БД на отдельный инстанс. Создадим 2 новых шаблона packer db.json и app.json.  
Создадим app.tf в который вынесем конфигурацию для ВМ с приложением.  
Аналогично создадим файл db.tf для ВМ с БД.  
В файл vpc.tf определим правило фаервола.  
Применим полученную конфигурацию терраформ.  
Создадим модули.  
Вынесем конфигурацию ВМ БД в отдельную директорию с файлами mail.tf, variables.tf и outputs.tf. db.td > modules/db/mail.tf  
Аналогично сделаем с app.  
Опишем в корневом main.tf оба модуля DB & APP и загрузим их командой terraform get.  
Параметризуем модуль vpc.  
Поиграем параметром source_ranges в модуле vpc в корневом файле main.tf.  
Создадим stage и prod.  
Перенесем все модули в директории stage & prod.  
Воспользуемся модулем storage-bucket для создания бакета в сервисе Storage.  



#Homework 7  
Terraform-1  
  
Удалим ключ appuser из метаданных в GCP  
Скачаем terraform, создадим пустой конфиг, добавим файлы в .gitignore.  
Добавим секцию провайдера в конфигурационный файл и инициализируем терраформ. `$ terraform init`  
В main.tf добавим ресурскоторый описывает ВМ.  
Посмотрим запланированные изменения командой `$ terraform plan `  
Применяем main.tf командой `$ terraform apply `  
В процессе применения конфига создается файл состояния terraform.tfstate  
Используя команду terraform show найдем ip адрес созданного инстанса `$ terraform show | grep assigned_nat_ip`  
По ssh к созданной ВМ не подключиться, так как мы удалили ключи из метаданных.  
Определим SSH ключ в main.tf  
Применим изменения - подключение заработало!  
Создадим файл outputs.tf который будет содержать выходные переменные. Например ip адрес инстанса.  
Посмотрим значения переемнных командой `$ terraform output `  
Добавим правило фаервола и тэг инстанса в main.tf  
Опишем провижинеры для деплоя приложения на ВМ. Применим изменения.  
Определим входные переменные при помощи variables.tf. Отредактируем main.tf  
Удалим все ресурсы `$ terraform destroy ` и создадим заново `$ terraform plan` `$ terraform apply`  


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



