# == Schema Information
# Schema version: 20090529235331
#
# Table name: leave_periods
#
#  id               :integer(4)      not null, primary key
#  leave_request_id :integer(4)
#  from_date        :date
#  until_date       :date
#  from_time        :time
#  until_time       :time
#  created_at       :datetime
#  updated_at       :datetime
#

class LeavePeriod < ActiveRecord::Base
  belongs_to :leave_request
  validate :check_valid
  def check_valid
    
  end
end
