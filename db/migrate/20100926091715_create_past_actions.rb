class CreatePastActions < ActiveRecord::Migration
  def self.up
    create_table :past_actions do |t|

      t.string   :description, :null=>false
      t.datetime :started_at, :null=>false
      t.datetime :ended_at
      t.integer  :user_id, :null=>false

      t.timestamps
    end
  end

  def self.down
    drop_table :past_actions
  end
end
