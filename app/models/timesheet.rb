class Timesheet < ActiveRecord::Base
  belongs_to :user
  has_one :accrual
  has_many :pto_allocations, :dependent => :delete_all
  before_create :ensure_pto_allocations_created
  
  private
    def ensure_pto_allocations_created
      start_date.to_date.upto end_date.to_date do |dt|
        pto_allocations << PtoAllocation.new( :allocation_date => dt )
      end

    end
end
