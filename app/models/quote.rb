class Quote < ActiveRecord::Base
  belongs_to :wall
  belongs_to :author, :class_name => "User" # foreign_key -> user_id
  has_and_belongs_to_many :users
  validates_presence_of :text

  attr_accessor :nice_text

  def nice_text
    self.text
  end
end
