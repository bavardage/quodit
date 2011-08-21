class User < ActiveRecord::Base

  has_and_belongs_to_many :quotes
  has_and_belongs_to_many :walls 

  has_many :authored_quotes, :class_name => "Quote", :foreign_key => "author_id"

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["user_info"]["name"]
      user.email = auth["user_info"]["email"]
    end
  end
end
