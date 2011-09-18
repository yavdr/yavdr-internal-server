class Github::ApiController < ApplicationController
  def hook
    payload = JSON.parse(params[:payload])

    unless payload['repository'].blank?
      repository = Repository.find_or_create_by_url(
        {
          name: payload['repository']['name'],
          url: payload['repository']['url']
        }
      )
      Rails.logger.info(repository.inspect)

      if repository.autobuild?
        branch = payload['ref'].gsub("refs/heads/", '')
        BuildMapping.where(:branch => branch).all.each do |build_mapping|
          Build.create!(
            {
              :repository_id => repository.id,
              :dist => build_mapping.dist,
              :stage => build_mapping.stage
            }
          )
        end
      end

      UserMailer.commit(payload).deliver

    end
    render :json => {:status => true}
  end
end
