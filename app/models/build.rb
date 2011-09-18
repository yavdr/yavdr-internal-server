class Build < ActiveRecord::Base
  belongs_to :github_repository, :class_name => 'Github::Repository'
  validates :github_repository_id, :presence => true
  validates :branch, :presence => true
  validates :dist, :presence => true
  validates :stage, :presence => true, :inclusion => {:in => ['unstable', 'testing', 'stable']}
  validates :status, :inclusion => {:in => ['waiting', 'inprocess', 'complete', 'error']}

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