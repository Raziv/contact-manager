class UsersController < ApplicationController
  def show
    @user = User.find(session[:user_id])
    @contacts = @user.contacts.order(:name)
  end

  def new
    if logged_in?
      user = User.find_by(id: session[:user_id])
      redirect_to user
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to @user
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end
