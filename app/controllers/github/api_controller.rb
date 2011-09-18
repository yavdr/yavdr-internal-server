class Github::ApiController < ApplicationController
  def hook
    payload = JSON.parse(params[:payload])

    unless payload['repository'].blank?
      repository = Repository.find_by_url(payload['repository']['url'])
      
      unless repository
        repository = Repository.create(
          {
            :name => payload['repository']['name'],
            :url => payload['repository']['url']
          }
        )
      end

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

      render :json => {:status => true}
    end
  end
end
