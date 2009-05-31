# == Schema Information
# Schema version: 20090529235331
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
#

class LeaveRequest < ActiveRecord::Base
  has_many :leave_periods
end
