class AddHolidayAccumulatorToAccrualModel < ActiveRecord::Migration
  def self.up
	  add_column :accruals, :holiday_time_in_period, :float, :default => 0.0
  end

  def self.down
	  remove_column :accruals, :holiday_time_in_period
  end
end
