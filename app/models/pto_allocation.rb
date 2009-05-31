# == Schema Information
# Schema version: 20090529235331
#
# Table name: pto_allocations
#
#  id              :integer(4)      not null, primary key
#  timesheet_id    :integer(4)
#  allocation_date :datetime
#  sick            :float           default(0.0)
#  vacation        :float           default(0.0)
#  holiday         :float           default(0.0)
#  created_at      :datetime
#  updated_at      :datetime
#  comp            :float           default(0.0)
#  military        :float           default(0.0)
#  bereavement     :float           default(0.0)
#  jury_duty       :float           default(0.0)
#  unpaid_leave    :float           default(0.0)
#  administrative  :float           default(0.0)
#  user_modified   :boolean(1)
#

class PtoAllocation < ActiveRecord::Base
  belongs_to :timesheet
  named_scope :holidays, :select => "pto_allocations.*", :joins => "inner join holidays on DATE(holidays.holiday_date) = DATE(pto_allocations.allocation_date)"

end
