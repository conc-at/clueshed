# ClueShed [![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)

[![Build Status](https://travis-ci.org/conc-at/clueshed.svg?branch=master)](https://travis-ci.org/conc-at/clueshed)
<a href="https://zenhub.io"><img src="https://raw.githubusercontent.com/ZenHubIO/support/master/zenhub-badge.png" height="18px"></a>
[![Code Climate](https://codeclimate.com/github/conc-at/clueshed/badges/gpa.svg)](https://codeclimate.com/github/conc-at/clueshed)
[![Test Coverage](https://codeclimate.com/github/conc-at/clueshed/badges/coverage.svg)](https://codeclimate.com/github/conc-at/clueshed)
[![security](https://hakiri.io/github/conc-at/clueshed/master.svg)](https://hakiri.io/github/conc-at/clueshed/master)

> "Interests and Contribs" for your Barcamp or Lightning-Talk track

## Development setup

---
create db-tables
```shell
$ rails db:create
```

run migrations
```shell
$ rails db:migrate
```
---

install dependencies
```shell
$ bundle install
```
---

start the OSX mail server
```shell
$ sudo postfix start
```
---
install figaro (for ENV-Vars)
```shell
$ bundle exec figaro install
```
-> This creates a commented *config/application.yml* file and adds it to your .gitignore.

__Add your own configuration to this file!__
-> refer to */config/aplication.example.yaml*

to create a new secret for SECRET_KEY_BASE run
```shell
$ rails secret
```
---
start the server
```shell
$ rails server
````
---
generate encrypted Heroku API-Key
```shell
$ travis encrypt $(heroku auth:token) --add deploy.api_key
```
-> will be copied into *.travis.yml*

## Production

push config variables to heroku
`$ figaro heroku:set -e production``


