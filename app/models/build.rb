class Build < ActiveRecord::Base
  belongs_to :repository
  validates :repository_id, :presence => true
  validates :branch, :presence => true, :length => {:maximum => 50}
  validates :dist, :presence => true, :length => {:maximum => 50}
  validates :stage, :presence => true, :inclusion => {:in => YavdrInternalServer::STAGES}
  validates :status, :inclusion => {:in => YavdrInternalServer::BUILD_STATUS}

  after_create :create_job
  after_destroy :delete_build_data

  def process
    #return unless status.to_sym == :waiting
    update_attribute :status, :inprocess

    if (repository.section == 'main')
      lprepo = 'main'
    else
      lprepo = "#{stage}-#{repository.section}"
    end

    r = false
    FileUtils.mkdir_p build_path
    Dir.chdir(build_path) do
      gitrepo = repository.url.gsub("https://", "git://") + ".git"
      r = system("#{Rails.root + 'script' + 'build.sh'} '#{repository.name}' '#{branch}' '#{dist}' '#{stage}' '#{repository.section}' '#{gitrepo}' 'medium' > build.log")
    end

    if r
      self.status = 'complete'
    else
      self.status = 'error'
    end
    self.save!
  end

  def self.cleanup
    where("created_at < ?", 1.month.ago)
  end

  def log_path
    build_path + "/build.log"
  end

  def build_path
    (Rails.root + 'shared' + 'builds' + self.id.to_s).to_s
  end

  private

  def delete_build_data
   Dir.remove build_path, :force => true
  end

  def create_job
    Delayed::Job.enqueue(BuildJob.new(id))
  end
end
