class PublishingsController < ApplicationController

	  before_action :authenticate_user

	  def create
    	list = List.find params[:list_id]
      @current_price = list.bids.maximum(:amount)
    if (list.bids.first != nil) && ((list.published?) && (@current_price >= list.reserve_price))
    	list.publish
      list.save
      redirect_to list, notice: "Succesfull met reserve price"
    elsif 
    	redirect_to list, alert: "Reserve Price not met yet!!!"
    end
  end
end