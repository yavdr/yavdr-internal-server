class RepositoriesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    
  end

  def update
    if @repository.update_attributes params[:repository]
      redirect_to :repositories, :notice => t('controller.repositories.saved')
    else
      render :edit
    end
  end
end
