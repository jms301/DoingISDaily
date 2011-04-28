class AddPlanIdToEvent < ActiveRecord::Migration
  def self.up
    add_column :events, :plan_id, :integer
  end

  def self.down
    remove_column :events, :plan_id
  end
end
