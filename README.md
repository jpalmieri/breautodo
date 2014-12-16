Blocitoff
==========

A self-destruction to-do list application. Made with my mentor at [Bloc](http://www.bloc.io).

This app allows each user to create a private todo list. Each todo list item will expire after 7 days of being on the list, at which time it will be deleted. The days left before the todo is deleted is also shown on the list.

Installation
=====

1. Clone the repo:
`$ git clone https://github.com/jpalmieri/blocitoff.git`

2. Open the new directory:
`$ cd blocitoff`

3. Create an `application.yml` file for your environment variables (by copying the example file):
`$ cp config/application.example.yml config/application.yml`

4. Generate a secret key for Devise authentication
`$ rake secret`

5. Copy and paste the secret next to `SECRET_KEY_BASE: `, like so:
`SECRET_KEY_BASE: XXXXXXXXXXXXXXX`

and save the file.

6. After logging into your (authorized) Heroku account, create a Heroku app:
`$ heroku create`

7. Add Sendgrid to Heroku:
`$ heroku addons:add sendgrid:starter`

8. Get Sendgrid credentials:
```
$ heroku config:get SENDGRID_USERNAME
$ heroku config:get SENDGRID_PASSWORD
```

9. Add the Sendgrid username and password to `config/application.yml` and save the file.

10. Use Figraro to update the environment variables:
`figaro heroku:set -e production`

11. Push the repo to heroku:
`git push heroku master`

12. Run the migrations:
```
rake db:migrate
heroku run rake db:migrate
```

13. Run `$ rails s` to start your server, and go to `localhost:3000` to view the local server, or go to the url listed in the Heroku output to view your app (run `heroku apps:info` to get the url).