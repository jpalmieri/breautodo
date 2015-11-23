Blocitoff
==========

A self-destruction to-do list application. Made with my mentor at [Bloc](http://www.bloc.io).

This app allows each user to create a private todo list. Each todo list item will expire after 7 days of being on the list, at which time it will be deleted. The days left before the todo is deleted is also shown on the list.

Installation
=====

Clone the repo:
```
$ git clone https://github.com/jpalmieri/blocitoff.git
```

Open the new directory: `$ cd blocitoff`

Create an `application.yml` file for your environment variables (by copying the example file):
```
$ cp config/application.example.yml config/application.yml
```

Generate a secret key for Devise authentication: `$ rake secret`

Copy and paste the secret next to `SECRET_KEY_BASE: `, like so:
```
SECRET_KEY_BASE: XXXXXXXXXXXXXXX
```

and save the file.

After logging into your (verified*) Heroku account, create a Heroku app:
`$ heroku create`

Add Sendgrid to Heroku:
`$ heroku addons:add sendgrid:starter`

Get Sendgrid credentials:
```
$ heroku config:get SENDGRID_USERNAME
$ heroku config:get SENDGRID_PASSWORD
```

Add the Sendgrid username and password to `config/application.yml` and save the file.

Use Figraro to update the environment variables:
`figaro heroku:set -e production`

Push the repo to heroku:
`git push heroku master`

Install gems: `$ bundle install`

Run the migrations:
```
bundle exec rake db:migrate
heroku run bundle exec rake db:migrate
```

Run `$ rails s` and go to `localhost:3000` to view the local server, or simply go to the url listed in the Heroku output to view your app (run `heroku apps:info` to get the url).

*You can find information on verifying a Heroku account here: [https://devcenter.heroku.com/articles/account-verification](https://devcenter.heroku.com/articles/account-verification)
