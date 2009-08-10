# == Schema Information
# Schema version: 20090805190920
#
# Table name: accruals
#
#  id                     :integer(4)      not null, primary key
#  vacation_hours         :float
#  holiday_hours          :float
#  sick_hours             :float
#  created_at             :datetime
#  updated_at             :datetime
#  effective_date         :datetime
#  discriminator          :string(255)
#  timesheet_id           :integer(4)
#  holiday_time_in_period :float           default(0.0)
#

class Accrual < ActiveRecord::Base
  #belongs_to :user
  belongs_to :timesheet
end
