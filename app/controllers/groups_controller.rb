class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def create
    @user = User.find_by(id: session[:user_id])
    @group = @user.groups.new(contact_params)
    if @group.save
      flash[:success] = "Success"
      redirect_to user_path(@user.id)
    else
      render 'new'
    end
  end

  def show
    @contacts = Contact.where(group_id: params[:id]).order(:name)
  end

  private

  def contact_params
    params.require(:group).permit(:name)
  end
end
