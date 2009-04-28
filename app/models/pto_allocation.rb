class PtoAllocation < ActiveRecord::Base
  belongs_to :timesheet
  named_scope :holidays, :select => "pto_allocations.*", :joins => "inner join holidays on DATE(holidays.holiday_date) = DATE(pto_allocations.allocation_date)"

end
