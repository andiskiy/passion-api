# PASSION-API

This is a RoR API application, which can work with external applications.

API is secured by jwt-tokens by using devise and devise-jwt gems.

To authorize in app you should send the request which will return the JWT-token on Header. Then use this token on headers of each request. 

The API can be scaled later by adding v2 version. 

This project developed with TDD principle, so there are Rspec tests.

## Used technologies

* Rails 5.2.3
* Ruby 2.6.3
* PostgreSQL
* Puma
* Authorization: `Devise`, `Devise-JWT` 

## Getting Started

Install [RVM](https://rvm.io/) with Ruby 2.6.3.


Copy:
```
cp .env.example .env
cp config/database.yml.example config/database.yml
```
For `config/database.yml` update your `username/password`

Install gems:
```
gem install bundler
bundle install
```

##### Install DB

empty data:
```
rake db:create
rake db:migrate
```

or with the seeds data:

```
rake db:setup
```

## Environmental Variables

```
AWS_ACCESS_KEY_ID      => your access key id from AWS
AWS_SECRET_ACCESS_KEY  => your secret access key from AWS
AWS_TOPIC_NAME         => your topic name AWS SNS
AWS_QUEUE_NAME         => your queue name AWS SQS
DEVISE_JWT_SECRET_KEY  => jwt secret key
```
