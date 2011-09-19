# encoding: utf-8
class BuildsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_builds, :only => :index

  load_and_authorize_resource

  def index

  end

  def create
    @build = Build.new params[:build]
    if @build.save
      redirect_to :builds, :notice => t('controller.builds.created')
    else
      render :new
    end
  end

  def show
    respond_to do |format|
      format.html
      format.log do
        if File.exists? @build.log_path
          send_file @build.log_path, :type => "text/plain", :disposition => "inline"
        else
          render :text => ""
        end
      end
    end
  end

  private

  def load_builds
    @builds = Build.order("created_at DESC").page params[:page]
  end
end