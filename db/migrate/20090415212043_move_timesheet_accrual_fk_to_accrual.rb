class MoveTimesheetAccrualFkToAccrual < ActiveRecord::Migration
  def self.up
    #remove_column :accruals, :user_id
    #add_column :accruals, :timesheet_id, :integer
    Timesheet.reset_column_information
    Timesheet.all.each {|t| 
      a=Accrual.find(t.starting_accrual_id)
      a.discriminator="start"
      t.starting_accrual=a
      t.save
    }
    remove_column :timesheets, :starting_accrual_id
    remove_column :timesheets, :ending_accrual_id

  end

  def self.down
    add_column :timesheets, :ending_accrual_id, :integer
    add_column :timesheets, :starting_accrual_id, :integer
    Timesheet.reset_column_information
    Timesheet.all.each {|t| 
      t.starting_accrual_id=t.starting_accrual.id
      t.ending_accrual_id=t.ending_accrual.id
      t.save
    }
    remove_column :accruals, :timesheet_id
    add_column :accruals, :user_id
  end
end
