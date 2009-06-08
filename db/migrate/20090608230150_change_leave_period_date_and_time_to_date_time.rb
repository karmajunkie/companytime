class ChangeLeavePeriodDateAndTimeToDateTime < ActiveRecord::Migration
  def self.up
	  change_column :leave_periods, :from_date, :datetime
	  change_column :leave_periods, :until_date, :datetime
	  remove_column :leave_periods, :from_time
	  remove_column :leave_periods, :until_time
	  add_column :leave_periods, :all_day, :boolean
  end

  def self.down
	  remove_column :leave_periods, :all_day, :boolean
	  add_column    :leave_periods, :until_time, :time
	  add_column    :leave_periods, :from_time, :time
	  change_column :leave_periods, :until_date, :date
	  change_column :leave_periods, :from_date, :date
  end
end
