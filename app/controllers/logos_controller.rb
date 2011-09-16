# encoding: utf-8
class LogosController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

#  before_filter :load_logo, :only => [:show, :update, :edit, :destroy]

  def index
    @logos = Logo.includes(:names).order("LOWER(logo_names.name)").all
  end

  def new
    @logo = Logo.new
  end

  def create
    @logo = Logo.new params[:logo]
    if @logo.save
      redirect_to :logos, :notice => "Logo wurde angelegt"
    else
      render :new
    end
  end

  def destroy
    @logo.destroy
    redirect_to :logos, :notice => "Logo wurde gelöscht"
  end

  def update
    if @logo.update_attributes params[:logo]
      redirect_to @logo, :notice => "Logo wurde geändert"
    else
      render :edit
    end

  end

  def export
    x = Logo.archive
    send_file x, :type => 'application/x-tar', :filename => 'logos.tar.gz'
  end

  private

  def load_logo
    @logo = Logo.find(params[:id])
  end

end
