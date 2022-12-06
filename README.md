# Ratebeer

This is a mandatory exercise for [Ruby on Rails -course](https://github.com/mluukkai/WebPalvelinohjelmointi2022/blob/main/wadror.md) at University of Helsinki. 

Live instance can be found at: [ratebeer.codecache.eu](https://ratebeer.codecache.eu)

## INSTALLATION

1. Clone repository

2. Create `config/master.key`

3. Run `sudo docker-compose up -d`

4. Drop shell inside `ratebeer` container and run `rails db:migrate`

## UPDATE

1. Pull latest changes: `git pull`

2. Stop current instance of app

3. Run `sudo docker-compose build`

4. Start app: `sudo docker-compose up -d`

5. Drop shell inside `ratebeer` container and run `rails db:migrate`
