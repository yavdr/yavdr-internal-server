class UsersController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def update
    if @user.update_attributes params[:user]
      redirect_to :users, :notice => t('controller.users.saved')
    else
      render :edit
    end
  end
end
