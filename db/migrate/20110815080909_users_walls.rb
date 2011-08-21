class UsersWalls < ActiveRecord::Migration
  def self.up
    create_table :users_walls, :id => false do |t|
      t.references :wall
      t.references :user
    end
  end

  def self.down
    drop_table :users_walls
  end
end
