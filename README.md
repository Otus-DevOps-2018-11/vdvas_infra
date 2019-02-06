# vdvas_infra
vdvas Infra repository
Подключение в одну строку к someinternalhost
```
        `ssh someinternalhost`
```
Я использую под Windows git ssh клиент Git Bash
Настроить MINGW64 на автозапуск ssh-agent
    eval $(ssh-agent -s)
    ssh-add ~/.ssh/GCP/appuser

В папке пользователя в папке .ssh создать файл config
    Host someinternalhost
         HostName 10.132.0.3
         User appuser
         ProxyCommand ssh -W %h:%p  appuser@35.195.200.220

После этого подключение будет работать в одну строку.
     
