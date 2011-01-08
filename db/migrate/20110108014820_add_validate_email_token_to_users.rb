class AddValidateEmailTokenToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :validate_email_token, :string
  end

  def self.down
    remove_column :users, :validate_email_token
  end
end
