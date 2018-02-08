class SessionsController < ApplicationController
  def new
    if logged_in?
      user = User.find_by(id: session[:user_id])
      redirect_to user
    end
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    # contact = user.contacts.order(:name)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
