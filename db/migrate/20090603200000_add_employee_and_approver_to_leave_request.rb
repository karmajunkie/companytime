class AddEmployeeAndApproverToLeaveRequest < ActiveRecord::Migration
  def self.up
    add_column :leave_requests, :employee_id, :integer
    add_column :leave_requests, :approver_id, :integer
  end

  def self.down
    remove_column :leave_requests, :employee_id
    remove_column :leave_requests, :approver_id
  end
end
