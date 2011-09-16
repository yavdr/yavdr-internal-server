class LogoName < ActiveRecord::Base
  belongs_to :logo
  validates :name, :presence => true, :uniqueness => true
end
