class OwnersController < ApplicationController



		@restaurants = Restaurant.where owner_id: current_owner
	end
end