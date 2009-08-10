# == Schema Information
# Schema version: 20090805190920
#
# Table name: leave_periods
#
#  id               :integer(4)      not null, primary key
#  leave_request_id :integer(4)
#  from_date        :datetime
#  until_date       :datetime
#  created_at       :datetime
#  updated_at       :datetime
#  all_day          :boolean(1)
#

class LeavePeriod < ActiveRecord::Base
  belongs_to :leave_request
#  validates_presence_of :leave_request
end
