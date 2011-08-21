class User < ActiveRecord::Base

  has_and_belongs_to_many :quotes
  has_many :memberships
  has_many :walls, :through => :memberships

  has_many :authored_quotes, :class_name => "Quote", :foreign_key => "author_id"

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["user_info"]["name"]
      user.email = auth["user_info"]["email"]
    end
  end

  def admined_walls
   Wall.find(:all, 
             :joins => {:memberships => :user}, 
             :conditions => {:memberships => { :role => "admin", 
                                               :user_id => u}})
  end

  def membered_walls
    Wall.find(:all, 
             :joins => {:memberships => :user}, 
             :conditions => {:memberships => { :role => "member", 
                                               :user_id => u}})
  end
end
