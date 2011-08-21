class CreateQuotes < ActiveRecord::Migration
  def self.up
    create_table :quotes do |t|
      t.references :author, :null => false
      t.string :text, :null => false
      t.references :wall, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :quotes
  end
end
