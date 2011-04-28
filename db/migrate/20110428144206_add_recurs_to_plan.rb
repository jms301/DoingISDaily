class AddRecursToPlan < ActiveRecord::Migration
  def self.up
    add_column :plans, :recurs, :integer
  end

  def self.down
    remove_column :plans, :recurs
  end
end
