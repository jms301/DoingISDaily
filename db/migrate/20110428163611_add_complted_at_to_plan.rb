class AddCompltedAtToPlan < ActiveRecord::Migration
  def self.up
    add_column :plans, :completed_at, :datetime
  end

  def self.down
    remove_column :plans, :completed_at
  end
end
