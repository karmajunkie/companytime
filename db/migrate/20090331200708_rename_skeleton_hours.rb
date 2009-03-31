class RenameSkeletonHours < ActiveRecord::Migration
  def self.up
    rename_column :users, :skeleton_hours, :holiday_hours
    remove_column :users, :comp_hours
  end

  def self.down
    add_column :users, :comp_hours
    rename_column :users, :holiday_hours, :skeleton_hours
  end
end
