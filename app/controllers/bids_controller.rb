class BidsController < ApplicationController

  before_action :set_bid, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user

  def index 
    @bids = current_user.bids
  end

  def create
    @list = List.find(params[:list_id])
    if @list.user != current_user
      @bid  = @list.bids.new bid_params
      @bid.user = current_user
      @bid.list = @list
      if @bid.amount && @bid.amount > @list.current_price.to_i
        respond_to do |format|
          if @bid.save
            list = List.find(@list)
            list.current_price = @bid.amount
            list.save
            format.html { redirect_to list_path(@list), notice: "Bid Successfully. Wee!" }
            format.js {render :create_success}
          else
            format.html { render "lists/show" }
            format.js {render :create_failure}
          end
        end
      else
        redirect_to list_path(@list), alert: "Bid amount is too low, Sorry =("
      end
      if @bid.amount && @bid.amount > @list.reserve_price.to_f
        list = List.find(@list)
        list.publish
        list.save
      end
    else
     redirect_to list_path(@list), notice: "Sorry can't bid on your own."
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
