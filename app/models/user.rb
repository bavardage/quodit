class User < ActiveRecord::Base

  has_and_belongs_to_many :quotes
  has_many :memberships
  has_many :walls, :through => :memberships

  has_many :authored_quotes, :class_name => "Quote", :foreign_key => "author_id"


  def self.create_user(provider, uid)
    user = User.find_by_provider_and_uid(provider, uid)
    unless user
      create! do |user|
        user.provider = provider
        user.uid = uid
        user.active = false
      end
    else
      user
    end
  end

  def self.create_with_omniauth(auth)
    # return or create user
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"])

    if user
      # unless 
      #   user.active = true
      #   user.name = auth["user_info"]["name"]
      #   user.email = auth["user_info"]["email"]
      #   user.save
      # end
      user
    else
      create! do |user|
        user.provider = auth["provider"]
        user.uid = auth["uid"]
        user.name = auth["user_info"]["name"]
        user.email = auth["user_info"]["email"]
        user.active = true
      end
    end
  end

  def admined_walls
   @admined_walls ||= Wall.find(:all, 
                                :joins => {:memberships => :user}, 
                                :conditions => {:memberships => {:role => "admin", 
                                                                 :user_id => self.id}})
  end

  def membered_walls
    @membered_walls ||= Wall.find(:all, 
                                  :joins => {:memberships => :user}, 
                                  :conditions => {:memberships => {:role => "member",
                                                                   :user_id => self.id}})
  end

  def has_role(wall, role)
    #TODO: cache this?!
    Wall.find(:first,
              :joins => :memberships,
              :conditions => {:memberships => {:role => role,
                                               :wall_id => wall,
                                               :user_id => self}})
  end

  def facebook_user(token)
    FbGraph::User.me(token)
  end
    
end
