# Wowhead Tooltips Realm Status
This a proof of concept application I wrote to prove the ability to be able to scrape data from WoW's new Battle.net website.  This is in anticipation of the new method of querying the new armory site.  While this is only a proof of concept application, it has all the bells and whistles, and is running full time at <http://realms.wowhead-tooltips.com> with the most up to date code.

## Installation

1. Grab the source code from the Git repository:
		git clone git@github.com:wowheadtooltips/realmstatus.git realmstatus
2. Rename `config/database.yml.example` to `config/database.yml`:
		mv config/database.yml.example config/database.yml
3. Edit `config/database.yml` to your liking. //MySQL is default, but any SQL flavor should work.//
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


