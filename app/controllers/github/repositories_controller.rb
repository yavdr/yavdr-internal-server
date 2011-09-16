class Github::RepositoriesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource :class => "Github::Repository"

  def index
    
  end

  def update
    if @repository.update_attributes params[:github_repository]
      redirect_to :github_repositories, :notice => "Repository wurde gespeichert"
    else
      render :edit
    end
  end
end
