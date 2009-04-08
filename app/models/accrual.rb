class Accrual < ActiveRecord::Base
  #belongs_to :user
  has_one :timesheet
end
