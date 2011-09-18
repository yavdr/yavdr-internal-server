class BuildMapping < ActiveRecord::Base
  validates :branch, :presence => true, :length => {:maximum => 50}
  validates :stage, :presence => true, :inclusion => {:in => YavdrInternalServer::STAGES}
  validates :dist, :presence => true, :length => {:maximum => 50}, :uniqueness => { :scope => [:branch, :stage] }
end
