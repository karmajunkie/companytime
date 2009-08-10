class ChangeTimesheetDateTimesToDate < ActiveRecord::Migration
  def self.up
	  change_column :timesheets, :start_date, :date
	  change_column :timesheets, :end_date, :date
  end

  def self.down
	  change_column :timesheets, :start_date, :datetime
	  change_column :timesheets, :end_date, :datetime
  end
end
