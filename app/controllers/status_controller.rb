class StatusController < ApplicationController
  def index
  	@realms = Realm.find(:all, :order => "name ASC")
  end

  def update
  end

	def gohome
		redirect_to 'http://wowhead-tooltips.com'
	end
	
	def forums
		redirect_to 'http://support.wowhead-tooltips.com'
	end
	
	def wiki
		redirect_to 'http://wiki.wowhead-tooltips.com'
	end
	
	def sitedb
		redirect_to 'http://sitedb.wowhead-tooltips.com'
	end
end
