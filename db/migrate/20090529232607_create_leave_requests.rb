class CreateLeaveRequests < ActiveRecord::Migration
  def self.up
    create_table :leave_requests do |t|
      t.integer(:employee)
      t.integer(:executive)
      t.text :reason
      t.float :vacation_hours
      t.float :holiday_hours
      t.float :sick_hours
      t.boolean :bereavement
      t.float :bereavement_hours
      t.boolean :military
      t.float :military_hours
      t.float :comp_hours
      t.boolean :jury_duty
      t.float :jury_hours
      t.boolean :unpaid
      t.float :unpaid_hours
      t.boolean :administrative
      t.float :administrative_hours

      t.timestamps
    end
  end

  def self.down
    drop_table :leave_requests
  end
end
