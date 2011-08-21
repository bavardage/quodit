class CreateMemberships < ActiveRecord::Migration
  def self.up
    create_table :memberships do |t|
      t.integer :user_id, :null => false
      t.integer :wall_id, :null => false
      t.string :role, :null => false #member, admin, invitee, requested_to_joinee

      t.timestamps
    end
  end

  def self.down
    drop_table :memberships
  end
end
