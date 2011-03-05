class StatusController < ApplicationController
  def index
  	
  	# if they want to update the realms, do that first
  	Realm.getrealms if !params[:do].nil? && params[:do] == "update"
  
		# for column sorting
		sort = case params[:sort]
			when 'name' then 'name ASC'
			when 'status' then 'status ASC'
			when 'type' then 'type ASC'
			when 'population' then 'population ASC'
			when 'locale' then 'locale ASC'
			when 'name_reverse' then 'name DESC'
			when 'status_reverse' then 'status DESC'
			when 'type_reverse' then 'type DESC'
			when 'population_reverse' then 'population DESC'
			when 'locale_reverse' then 'locale DESC'
		end
		
		# for when the page is first loaded
		sort = 'name ASC' if params[:sort].nil?
		params[:page] = 1 if params[:page].nil?
		
		# see how they want to filter
		if params[:filter].nil?
			# for searches
			conditions = ["name LIKE ?", "%#{params[:query]}%"] unless params[:query].nil?
		else
			# filter by first character
			if params[:filter] == 'reset'
				conditions = ''
			else
				conditions = ["name LIKE ?", "#{params[:filter]}%"]
			end
		end
		
		# see if they want to filter by realm type
		conditions = ["realmtype LIKE ?", "%#{params[:type]}%"] if !params[:type].nil? && params[:type].downcase.gsub(' ', '') != 'filterbytype'
		# or maybe population?
		conditions = ["population LIKE ?", "%#{params[:pop]}%"] if !params[:pop].nil? && params[:pop].downcase.gsub(' ', '') != 'filterbypopulation'
		# or perhaps locale?
		conditions = ["locale LIKE ?", "%#{params[:locale]}%"] if !params[:locale].nil? && params[:locale].downcase.gsub(' ', '') != 'filterbylocale'
		
		# pull the sites from the database
		@total = Realm.count(:conditions => conditions)
		@realms = Realm.paginate :page => params[:page], :per_page => 50, :conditions => conditions, :order => sort
		
		# highlight the search query
		if !params[:query].nil? && !params[:query].empty?
			@realms.each {|realm| realm.name.gsub!("#{params[:query]}", "<span class=\"highlight\">#{params[:query]}</span>")}
		end
		
		# use ajax to update the site list
		if request.xml_http_request?
			render :partial => "realms_list", :layout => false
		else
			respond_to do |format|
				format.html
				format.xml { render :layout => false, :xml => @sites.to_xml() }
			end
		end
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
