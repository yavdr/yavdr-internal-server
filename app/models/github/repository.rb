class Github::Repository < ActiveRecord::Base
  validates :name, :presence => true
  validates :url, :presence => true, :uniqueness => true
  validates :build_type, :inclusion => { :in => ['autobuild', 'buildable'] }, :allow_nil => true, :allow_blank => true

  attr_accessible :build_type

  default_scope order(:name)

  def autobuild?
    build_type.to_s == 'autobuild' or buildable?
  end

  def buildable?
    build_type.to_s == 'buildable'
  end

end
