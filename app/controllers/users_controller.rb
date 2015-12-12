class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update]

	def new
    if !current_user
      @user = User.new 
    else
      redirect_to root_path
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to lists_path, notice: "Hello, Welcome!"
    else
      render :new
    end
  end

  def edit 
  end

  def index
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to root_path, notice: 'user was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, 
                                :password, :password_confirmation)
  end

end
