class RemoveAwesomeFromEvents < ActiveRecord::Migration
  def self.up
    remove_column :events, :awesome
  end

  def self.down
    add_column :events, :awesome, :boolean, :default=>false, :null=>false
  end
end
