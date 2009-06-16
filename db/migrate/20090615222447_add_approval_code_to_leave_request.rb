class AddApprovalCodeToLeaveRequest < ActiveRecord::Migration
  def self.up
	  add_column :leave_requests, :approval_code, :string
  end

  def self.down
	  remove_column :leave_requests, :approval_code
  end
end
