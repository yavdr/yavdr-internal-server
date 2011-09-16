class Github::ApiController < ApplicationController
  def hook
    payload = JSON.parse(params[:payload])

    Repository.find_or_create_by_url(
      {
        name: payload['repository']['name'],
        url: payload['repository']['url']
      }
    )
  end
end
