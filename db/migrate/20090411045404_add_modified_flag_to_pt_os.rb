class AddModifiedFlagToPtOs < ActiveRecord::Migration
  def self.up
    add_column :pto_allocations, :user_modified, :boolean, :default => false
  end

  def self.down
    remove_column :pto_allocations, :user_modified
  end
end
