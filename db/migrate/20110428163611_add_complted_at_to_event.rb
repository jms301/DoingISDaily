class AddCompltedAtToEvent < ActiveRecord::Migration
  def self.up
    add_column :events, :completed_at, :datetime
  end

  def self.down
    remove_column :events, :completed_at
  end
end
