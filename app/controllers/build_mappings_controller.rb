class BuildMappingsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index

  end

  def create
    @build_mapping = BuildMapping.new params[:build_mapping]
    if @build_mapping.save
      redirect_to :build_mappings, :notice => t('controller.build_mappings.created')
    else
      render :new
    end
  end

  def destroy
    @build_mapping.destroy
    redirect_to :build_mappings, :notice => t('controller.build_mappings.destroyed')
  end

  def update
    if @build_mapping.update_attributes params[:build_mapping]
      redirect_to :build_mappings, :notice => t('controller.build_mappings.updated')
    else
      render :edit
    end
  end

end
