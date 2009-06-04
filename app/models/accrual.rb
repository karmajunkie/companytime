# == Schema Information
# Schema version: 20090603200000
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
#  discriminator  :string(255)
#  timesheet_id   :integer(4)
#

class Accrual < ActiveRecord::Base
  #belongs_to :user
  belongs_to :timesheet
end
