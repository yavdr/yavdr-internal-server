class Repository < ActiveRecord::Base
  validates :name, :presence => true, :length => {:maximum => 100}
  validates :url, :presence => true, :uniqueness => true, :length => {:maximum => 250}
  validates :build_type, :inclusion => {:in => ['autobuild', 'buildable']}, :allow_nil => true, :allow_blank => true

  attr_accessible :build_type

  default_scope order(:name)

  def autobuild?
    build_type.to_s == 'autobuild'
  end

  def buildable?
    build_type.to_s == 'buildable' or autobuild?
  end

end
