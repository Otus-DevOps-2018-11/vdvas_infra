Homework 5

Config description:
testapp_IP = 35.204.7.238 testapp_port = 9292

Скрипты , находящиеся в репозитории.
install_ruby.sh - установка ruby
install_mongodb.sh - установка mongodb
deploy.sh - установка зависимостей.
install.sh - объединенные 3 скрипта выше в одну команду для указания gcloud как аргумент ключа metadata-from-file.

Команда для создания инстанса и запуска скрипта по установке ruby, mongod и запуску puma.
```
gcloud compute instances create reddit-app10 \
--boot-disk-size=10GB \
--image-family ubuntu-1604-lts \
--image-project=ubuntu-os-cloud \
--machine-type=g1-small \
--tags puma-server  \
--zone europe-west4-a  \
--restart-on-failure \
--metadata-from-file startup-script=install.sh
```

