class ConvertHolidayToDate < ActiveRecord::Migration
  def self.up
    change_column :holidays, :holiday_date, :date
  end

  def self.down
    change_column :holidays, :holiday_date, :datetime
  end
end
