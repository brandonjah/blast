class PagesController < ApplicationController
	layout "home"
	def home
		@contents = Content.all.to_a
	end
end