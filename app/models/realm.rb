class Realm < ActiveRecord::Base
	set_inheritance_column :ruby_type

	def self.getrealms
		# empty the database
		Realm.delete_all
		# query the new site
		url = "http://us.battle.net/wow/en/status"
		data = Nokogiri::HTML(open(url, "UserAgent" => "Ruby-OpenURI").read)
		rows = ["tr.row1", "tr.row2"]
		rows.each do |x|
			data.css(x).each do |row|
				realm = Realm.new
				realm.name = row.css("td.name").text.squish
				if row.at_css("td.status div")["class"] == "status-icon up"
					realm.status = "up"
				else
					realm.status = "down"
				end
				realm.type = row.css("td.type span").text.squish.gsub('(', '').gsub(')', '')
				realm.population = row.css("td.population span").text.squish
				realm.locale = row.css("td.locale").text.squish
				if row.css("td.queue").text.squish.empty?
					realm.queue = "None"
				else
					realm.queue = row.css("td.queue").text.squish
				end	
				realm.save
			end
		end
	end
	
	def self.first_letter(letter)
		@realms = self.find(:all, :conditions => ['LOWER (name) LIKE ?', "#{letter.downcase}%"], :order => 'name ASC')
		@realms.count
	end
	
	# list the realms in select form
	def self.get_realms_for_select
		#realms = self.find_by_sql("SELECT `realm` FROM `sites` ORDER BY `realm` ASC")
		sites = self.find(:all)
		realms = []
		x = 0
		sites.each do |site|
			realms[x] = site.realm.titleize.gsub('\\', '') if ! realms.nil? && ! realms.include?(site.realm.titleize.gsub('\\', ''))
			x += 1
		end
		realms = realms.compact.sort
		realms.reject(&:blank?)
		realms.insert(0, 'Sort by Realm')
	end
end
