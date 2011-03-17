# Wowhead Tooltips Realm Status
This a proof of concept application I wrote to prove the ability to be able to scrape data from WoW's new Battle.net website.  This is in anticipation of the new method of querying the new armory site.  While this is only a proof of concept application, it has all the bells and whistles, and is running full time at <http://realms.wowhead-tooltips.com> with the most up to date code.

## Installation

1. Grab the source code from the Git repository:
		git clone git@github.com:wowheadtooltips/realmstatus.git realmstatus
2. Rename `config/database.yml.example` to `config/database.yml`:
		mv config/database.yml.example config/database.yml
3. Edit `config/database.yml` to your liking. *MySQL is default, but any SQL flavor should work.*
		adapter: mysql
		encoding: utf8
		reconnect: false
		database: realmstatus
		pool: 5
		username: <username>
		password: <password>
		socket: /var/tmp/mysql.sock
4. Create the database tables:
		rake db:migrate
5. Run `ruby script/update` from the command line to parse the realm list and fill your database.
6. **OPTIONAL** The application is designed to request an update every hour.  You could setup a CRON job to run the `ruby script/update` script every x, or use the built in system.

## TODO
+ I am aware that the sort by first letter is not currently functioning.  While I am not sure why, I will get it fixed A.S.A.P.

## Requirements
+ Ruby 1.8.7
+ Rails 2.3.8
+ open-uri
+ will_paginate 2.3.15
+ Phusion Passenger 3.0.2 (for deployment via Apache)
+ **All required gems are located in the `vendor` folder.**

## Contact
+ Website: <http://wowhead-tooltips.com>
+ E-Mail: <adam@wowhead-tooltips.com>
+ Github: <https://github.com/wowheadtooltips>

