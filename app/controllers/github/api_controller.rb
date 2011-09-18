class Github::ApiController < ApplicationController
  def hook
    payload = JSON.parse(params[:payload])

    repository = Repository.find_by_url(payload['repository']['url'])
    
    if repository.nil?
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

      UserMailer.commit(payload).deliver

    end

    render :json => {:status => true}
  end
end
