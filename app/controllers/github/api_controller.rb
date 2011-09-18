class Github::ApiController < ApplicationController
  def hook
    payload = JSON.parse(params[:payload])

    unless payload['repository'].blank?
      Github::Repository.find_or_create_by_url(
        {
          name: payload['repository']['name'],
          url: payload['repository']['url']
        }
      )

      UserMailer.commit(payload).deliver

      render :json => { :status => true }
    end
  end
end
