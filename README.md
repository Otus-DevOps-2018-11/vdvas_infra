Homework 5

Команда для создания инстанса и запуска скрипта по установке ruby, mongod и запуску puma.
```
gcloud compute instances create reddit-app10 --boot-disk-size=10GB --image-family ubuntu-1604-lts --image-project=ubuntu-os-cloud --machine-type=g1-small --tags puma-server  --zone europe-west4-a  --restart-on-failure  --metadata-from-file startup-script=install.sh
```

