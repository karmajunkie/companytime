class AddLeaveCodeToLeaveRequest < ActiveRecord::Migration
  def self.up
    add_column :leave_requests, :leave_code, :string
  end

  def self.down
    remove_column :leave_requests, :leave_code
  end
end
