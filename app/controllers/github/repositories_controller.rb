class Github::RepositoriesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource :class => "Github::Repository"

  def index
    
  end
end
