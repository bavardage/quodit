class Wall < ActiveRecord::Base
  has_many :memberships
  has_many :users, :through => :memberships
  has_many :quotes

end
