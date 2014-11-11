class PagesController < ApplicationController
	layout "home"
	def home
		@contents = Content.all.to_a
	end
	
	def privacy
	end
end