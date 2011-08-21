class QuotesUsers < ActiveRecord::Migration
  def self.up
    create_table :quotes_users, :id => false do |t|
      t.references :quote
      t.references :user
    end
  end

  def self.down
    drop_table :quotes_users
  end
end
