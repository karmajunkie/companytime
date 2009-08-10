# == Schema Information
# Schema version: 20090805190920
#
# Table name: leave_requests
#
#  id                   :integer(4)      not null, primary key
#  employee             :integer(4)
#  executive            :integer(4)
#  reason               :text
#  vacation_hours       :float
#  holiday_hours        :float
#  sick_hours           :float
#  bereavement          :boolean(1)
#  bereavement_hours    :float
#  military             :boolean(1)
#  military_hours       :float
#  comp_hours           :float
#  jury_duty            :boolean(1)
#  jury_hours           :float
#  unpaid               :boolean(1)
#  unpaid_hours         :float
#  administrative       :boolean(1)
#  administrative_hours :float
#  created_at           :datetime
#  updated_at           :datetime
#  employee_id          :integer(4)
#  approver_id          :integer(4)
#  leave_code           :string(255)
#  approval_code        :string(255)
#  leave_type_id        :integer(4)
#

class LeaveRequest < ActiveRecord::Base
  has_many :leave_periods
  belongs_to :employee, :foreign_key => "employee_id", :class_name => "User"
  belongs_to :approver, :foreign_key => "approver_id", :class_name => "User"
  belongs_to :leave_type

  accepts_nested_attributes_for :leave_periods

  named_scope :pending, :conditions => {:approval_code => nil}

	validates_presence_of :employee
end
