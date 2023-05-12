class HomeController < ApplicationController
	before_action :not_admin?
	
	def index
		@in_progress = Lot.where('status = 5 and start_date <= ? and end_date >= ?', Date.today, Date.today)
		@future = Lot.where('status = 5 and start_date > ?', Date.today)
	end
end