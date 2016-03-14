Breutodo
==========

A to-do list application. This was started as a project for [Bloc](http://www.bloc.io).

Installation
=====

_Note: This app is intended to use Heroku for production and Sendgrid to send emails, so you'll need to set both of those up unless you want to deploy this app some other way._

## Initial Setup

Clone the repo:
```
$ git clone https://github.com/jpalmieri/breautodo.git
```

Open the new directory: `$ cd breautodo`

Install Postgres (if not already installed) with [Homebrew](http://brew.sh/): `$ brew install postgrsql`

Install gems: `$ bundle install`

## Set Environment Variables

This app is set up to use Heroku for production and Sendgrid to send emails, so you'll need to set both of those up.

After logging into your ([verified](https://devcenter.heroku.com/articles/account-verification)) Heroku account, create a Heroku app:

`$ heroku create`

Create an `application.yml` file for your environment variables (by copying the example file):
```
$ cp config/application.example.yml config/application.yml
```

Add Sendgrid to Heroku:
`$ heroku addons:add sendgrid:starter`

Get Sendgrid credentials:
```
$ heroku config:get SENDGRID_USERNAME && heroku config:get SENDGRID_PASSWORD
```

Generate a secret key for Devise authentication: `$ bundle exec rake secret`

Get your new app's domain:
`$ heroku domains`

Copy and paste the secret, the Sendgrid credentials, and your app's domain into application.yml, like so:
```
SENDGRID_USERNAME: yoursendgridusername
SENDGRID_PASSWORD: yoursendgridpassword
SECRET_KEY_BASE: yoursecret1234567
SENDER_EMAIL: youremailaddress@example.com  # Address you want Sendgrid emails to be sent from
APP_DOMAIN: something-awesome-12345.herokuapp.com
```
and save the file.

## Migrating and Deploying

### Local

Run the migrations: `$ bundle exec rake db:migrate`

To start the server locally, run `$ bundle exec rails s` and go to `localhost:3000` in your browser to view the app.

_Note: If you want to run tests locally, you'll need to install PhantomJS (for feature tests):_ `$ brew install phantomjs`

### Depolying to Heroku

Use Figraro to update the environment variables on Heroku:
`$ figaro heroku:set -e production`

Push the repo to Heroku:
`$ git push heroku master`

And run the migrations:
`$ heroku run bundle exec rake db:migrate`

Limit the [threads](https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server#thread-safety):
`$ heroku config:set MIN_THREADS=1 MAX_THREADS=1`

And then go to your app's domain in your browser (hint: `$ heroku domains`).
