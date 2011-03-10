module StatusHelper
	def realm_url_helper(realm, locale)
		eu = ['english', 'french', 'german', 'russian', 'spanish', 'oceanic']
		url = 'http://wowwiki.com/Server:' + realm.titleize.gsub(' ', '_').gsub('\\', '')
		url += '_Europe' if eu.include?(locale.downcase)
		link_to realm.titleize.gsub('\\', ''), url
	end
	
	def sort_first_character(text)
		
		# make sure they don't want to reset
		if text == 'reset'
			link_to_remote text.titleize,
			{:update => 'table', :before => "jQuery('#spinner-char').show()", :success => "jQuery('#spinner-char').hide()", :url => {:controller => 'status', :action => 'index', :params => params.merge({:filter => 'reset', :page => nil})}},
			{:title => "Reset Filter", :href => '#'}
		else 
			# get the count of the letter
			count = Realm.first_letter(text)
		
			# set the filter
			filter = text.downcase if count > 0
			
			if count == 0
				# if no sites, just show the letter
				text.upcase
			else
				# otherwise, create an AJAX link to sort via the letter
				link_to_remote text.upcase,
					{:update => 'table', :before => "jQuery('#spinner-char').show()", :success => "jQuery('#spinner-char').hide()", :url => {:controller => 'status', :action => 'index', :params => params.merge({:filter => filter, :page => nil})}},
					{:title => "#{count} Realms", :href => '#'}
			end
		end
	end

	def sort_site_helper(text, param)
		key = param
		key += "_reverse" if params[:sort] == param
		key = "name_reverse" if params[:sort].nil?
		link_to_remote text,
			{:update => 'table', :before => "jQuery('#spinner-#{param}').show()", :success => "jQuery('#spinner-#{param}').hide()", :url => {:controller => 'status', :action => 'index', :params => params.merge({:sort => key, :page => nil})}},
			{:class => sort_th_class_helper(param), :title => "sort by this field", :href => '#'} #url_for(:action => 'index', :params => params.merge({:sort => key, :page => nil}))}
	end
	
	def sort_th_class_helper(param)
		result = 'sort-asc' if params[:sort] == param
		result = 'sort-desc' if params[:sort] == param + '_reverse'
		return result
	end
end
