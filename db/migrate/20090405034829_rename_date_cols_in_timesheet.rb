class RenameDateColsInTimesheet < ActiveRecord::Migration
  def self.up
    rename_column :timesheets, :period_begin, :start_date
    rename_column :timesheets, :period_end, :end_date
  end

  def self.down
    rename_column :timesheets, :end_date, :period_end
    rename_column :timesheets, :start_date, :period_begin
  end
end
