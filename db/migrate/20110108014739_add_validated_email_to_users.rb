class AddValidatedEmailToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :validated_email, :boolean
  end

  def self.down
    remove_column :users, :validated_email
  end
end
