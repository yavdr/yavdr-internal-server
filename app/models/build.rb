class Build < ActiveRecord::Base
  belongs_to :repository
  validates :repository_id, :presence => true
  validates :branch, :presence => true, :length => { :maximum => 50 }
  validates :dist, :presence => true, :length => {:maximum => 50}
  validates :stage, :presence => true, :inclusion => {:in => YavdrInternalServer::STAGES}
  validates :status, :inclusion => {:in => YavdrInternalServer::BUILD_STATUS}

  after_create :create_job

  def process
    return unless status.to_sym == :waiting
    update_attribute :status, :inprocess
    begin

      self.status = 'complete'
      self.save!
    rescue Exception => e
      p e
      self.log = e
      self.status = 'error'
      self.save!
    end
  end

  private

  def create_job
    Delayed::Job.enqueue(BuildJob.new(id))
  end
end
