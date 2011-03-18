class Realm < ActiveRecord::Base
	POPULATION = [
		'Filter by Population',
		'Low',
		'Medium',
		'High'
	]
	
	def self.getrealms
		# empty the database
		self.delete_all
		
		# table rows for each realm
		rows = ["tr.row1", "tr.row2"]
		
		# current timestamp
		timenow = Time.now
		
		# the two realm status site urls
		urls = ["http://us.battle.net/wow/en/status", "http://eu.battle.net/wow/en/status"]
		urls.each do |url|
			# pull data from battle.net sites
			data = Nokogiri::HTML(open(url, "UserAgent" => "Ruby-OpenURI").read)
			rows.each do |x|
				data.css(x).each do |row|
					realm = Realm.new
					realm.name = row.css("td.name").text.squish
					if row.at_css("td.status div")["class"] == "status-icon up"
						realm.status = "up"
					else
						realm.status = "down"
					end
					realm.realmtype = row.css("td.type span").text.squish.gsub('(', '').gsub(')', '')
					realm.population = row.css("td.population span").text.squish
					realm.locale = row.css("td.locale").text.squish
					realm.added = timenow
					realm.wiki = 'http://wowwiki.com/Server:' + row.css("td.name").text.squish.gsub(' ', '_').gsub('\\', '')
					realm.wiki += '_Europe' if ['english', 'french', 'german', 'russian', 'spanish', 'oceanic'].include?(row.css("td.locale").text.squish.downcase)
					if row.css("td.queue").text.squish.empty?
						realm.queue = "None"
					else
						realm.queue = row.css("td.queue").text.squish
					end
					realm.flag = row.css("td.locale").text.squish.downcase.gsub(' ', '') + ".png"
					realm.save
				end
			end
		end
	end
	
	def self.first_letter(letter)
		@realms = self.find(:all, :conditions => ['LOWER (name) LIKE ?', "#{letter.downcase}%"], :order => 'name ASC')
		@realms.count
	end
	
	# list of types for select form
	def self.gettypes
		realms = self.find(:all, :select => "realmtype")
		types = []; x = 0;
		realms.each do |realm|
			if !types.nil? && !types.include?(realm.realmtype)
				types[x] = realm.realmtype
				x += 1
			end
		end
		types = types.compact.sort
		types.insert(0, 'Filter by Type')
	end
	
	# list of locales for select form
	def self.getlocales
		realms = self.find(:all, :select => "locale")
		locales = []; x = 0;
		realms.each do |realm|
			if !locales.nil? && !locales.include?(realm.locale)
				locales[x] = realm.locale
				x += 1
			end
		end
		locales = locales.compact.sort
		locales.insert(0, 'Filter by Locale')
	end
	
	# see if realms require an update
	def self.update?
		# return true if there are no realms
		return true if Realm.count(:all) == 0
		
		# get the current timestamp
		cur = Time.now.to_i
		
		# get the last update from sql, plus one hour (3600 seconds)
		entry = self.first
		added = entry.added.to_i + 1.hour # => 3600 seconds is one hour
		
		# if an hour has passed since last update, then another is required
		return cur > added ? true : false
	end
	
	def self.lastupdate
		return false if Realm.count(:all) == 0
		entry = self.first
		entry.added
	end
end
