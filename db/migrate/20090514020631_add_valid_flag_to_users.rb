class AddValidFlagToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :valid_user, :boolean, :default => true
  end

  def self.down
    remove_column :users, :valid
  end
end
