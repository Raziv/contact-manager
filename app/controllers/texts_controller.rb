require 'twilio-ruby'

class TextsController < ApplicationController

  def show
    @contact = Contact.find_by(id: params[:id])
  end

  def create
    @user = User.find_by(id: session[:user_id])
    account_sid = 'AC445508c8bcdb1f56311fee41e60cd5be' #ENV["ACCOUNT_SID"]
    auth_token = '54bb7fa9585b67e8448f9e0cfb74e837' #ENV["AUTH_TOKEN"]

    # set up a client to talk to the Twilio REST API
    @client = Twilio::REST::Client.new account_sid, auth_token

    from = '+14387952534' #ENV["PHONE_FROM"]

    @client.api.account.messages.create(
      :from => from,
      :to => params[:sendto],
      :body => params[:message],
    )
    flash[:success] = "Sent"
    redirect_to user_path(@user.id)
  end

end
