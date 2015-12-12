class BidsController < ApplicationController

  before_action :set_bid, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user

  def index 
    @bids = current_user.bids
  end

	def create
    @list = List.find(params[:list_id])
    @bid = Bid.new(bid_params)
    @bid.user = current_user
    @bid.list = @list
    if (@list.bids.maximum(:amount) < @bid.amount)  (@list.bids.first.amount == nil)
      respond_to do |format|
        if @bid.save
          format.html { redirect_to list_path(@list), notice: "bid added. Wee!" }
          format.js {render :create_success}
        else
          format.html { render "lists/show" }
          format.js {render :create_failure}
        end
      end
    else
      redirect_to list_path(@list), alert: "Bid amount is too low, Sorry =("
    end
  end

  def destroy
    @bid = Bid.find(params[:id])
    redirect_to list, alert: "Access denied!" unless can?(:destroy, @bid)
    @bid.destroy
    respond_to do |format|
      format.html  { redirect_to list_path(@bid.list), notice: "Comment Deleted" }
      format.js {render }
    end
  end

  private
    def set_bid
      @bid = Bid.find(params[:id])
    end

    def bid_params
      params.require(:bid).permit(:amount)
    end
end
