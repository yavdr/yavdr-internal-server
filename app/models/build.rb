class Build < ActiveRecord::Base
  belongs_to :repository
  validates :repository_id, :presence => true
  validates :branch, :presence => true, :length => {:maximum => 50}
  validates :dist, :presence => true, :length => {:maximum => 50}
  validates :stage, :presence => true, :inclusion => {:in => YavdrInternalServer::STAGES}
  validates :status, :inclusion => {:in => YavdrInternalServer::BUILD_STATUS}

  after_create :create_job
  after_destroy :delete_log

  def process
    return unless status.to_sym == :waiting
    update_attribute :status, :inprocess

    if (repository.section == 'main')
      lprepo = 'main'
    else
      lprepo = "#{stage}-#{repository.section}"
    end
    
    gitrepo = repository.url.gsub("https://", "git://") + ".git"
    r = system("#{Rails.root + 'script' + 'build.sh'} '#{repository.name}' '#{branch}' '#{dist}' '#{lprepo}' '#{gitrepo}' > #{log_path}")

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
    (Rails.root + 'shared' + 'builds' + "#{self.id}.log").to_s
  end

  private

  def delete_log
    File.remove log_path, :force => true
  end

  def create_job
    Delayed::Job.enqueue(BuildJob.new(id))
  end
end
