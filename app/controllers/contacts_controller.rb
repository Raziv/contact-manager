class ContactsController < ApplicationController
  def index
    @contacts = Contact.where(user_id: session[:user_id]).order(:name)
  end

  def show
    @contacts = Contact.where(id: params[:id])
  end

  def new
    @contact = Contact.new
  end

  def create
    @user = User.find_by(id: session[:user_id])
    @contact = @user.contacts.new(contact_params)
    if @contact.save
      flash[:success] = "Success"
      redirect_to user_path(@user.id)
    else
      render 'new'
    end
  end

  def edit
    @contact = Contact.find(params[:id])
  end

  def update
    @user = User.find_by(id: session[:user_id])
    @contact = Contact.find(params[:id])
    if @contact.update(contact_params)
      flash[:success] = "Success"
      redirect_to user_path(@user.id)
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find_by(id: session[:user_id])
    Contact.find(params[:id]).destroy
    flash[:success] = "Contact deleted"
    redirect_to user_path(@user.id)
  end

  def search
    @user = User.find_by(id: session[:user_id])
    @contacts = @user.contacts.where(['lower(name) LIKE lower(?)', "%#{params[:search]}%"])
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :company, :address, :phone, :group_id)
  end
end
