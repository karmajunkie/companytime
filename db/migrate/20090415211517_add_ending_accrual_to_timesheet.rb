class AddEndingAccrualToTimesheet < ActiveRecord::Migration
  def self.up
    add_column :timesheets, :ending_accrual_id, :integer
    rename_column :timesheets, :accrual_id, :starting_accrual_id
  end

  def self.down
    rename_column :timesheets, :starting_accrual_id, :accrual_id
    remove_column :timesheets, :ending_accrual_id
  end
end
