class RestaurantsController < ApplicationController
	before_action :authenticate_owner!, except: [:index, :show]
	before_action :set_restaurant, only: [:edit, :update, :destroy]

	private

	def set_restaurant
		@restaurant = current_owner.restaurants.find(params[:id])
	    rescue ActiveRecord::RecordNotFound
			redirect_to(root_url, :notice => "You don't own this restaurant!")
  end


public

	def index
		@restaurant = Restaurant.all
	end

	def new
		@restaurant = current_owner.restaurants.new
	end

	def create
		@restaurant = current_owner.restaurants.new(params.require(:restaurant).permit(:name, :description, :address, :phone))
		if @restaurant.save
			redirect_to restaurants_url
		else
			render action: "new"
		end
	end

	def edit
		@restaurant = current_owner.restaurants.find(params[:id])
	end

	def update
		@restaurant = current_owner.restaurants.find(params[:id])

		if @restaurant.update_attributes(params.require(:restaurant).permit(:name, :description, :address, :phone))
			redirect_to restaurants_path
		else
			render action: "edit"
		end
	end

	def show
		@restaurant = Restaurant.find(params[:id])
	end

	def destroy
		@restaurant = current_owner.restaurants.find(params[:id])
		@restaurant.destroy
		redirect_to restaurants_url
	end




end
