# == Schema Information
# Schema version: 20090529235331
#
# Table name: accruals
#
#  id             :integer(4)      not null, primary key
#  vacation_hours :float
#  holiday_hours  :float
#  sick_hours     :float
#  created_at     :datetime
#  updated_at     :datetime
#  effective_date :datetime
#  timesheet_id   :integer(4)
#  discriminator  :string(255)
#

class Accrual < ActiveRecord::Base
  #belongs_to :user
  belongs_to :timesheet
end
