class Timesheet < ActiveRecord::Base
  belongs_to :user
  has_one :accrual
  has_many :pto_allocations, :dependent => :delete_all
  before_create :ensure_pto_allocations_created

  validates_presence_of :start_date
  validates_presence_of :end_date
  
  def autoassign_pto
    comp_total=0.0
    #convert the total_hours to an array of 2-element arrays so we can treat it like a hash
    #with rassoc
    tot_hrs=user.work_periods.for_month(start_date).total_hours.map!{ |wkday|
      comp_total+=wkday.total_hours.to_f - 8.0 if wkday.total_hours.to_f > 8 || wkday.date_worked.cwday > 5
      [wkday.total_hours.to_f, wkday.date_worked]
    }

    tcomp=comp_total 
    pto_allocations do |pto|
      elm=tot_hrs.rassoc(pto.allocation_date.strftime("%m/%d/%Y"))
      hrs_for_day= elm ? elm[0] : 0.0
      if hrs_for_day >= 8
        pto.comp=8-hrs_for_day 
      else
        pto.comp=-1*[(8-hrs_for_day), tcomp].min
        tcomp-=pto.comp
      end

    end
    [tcomp, comp_total]

  end
  private
    def ensure_pto_allocations_created
      start_date.to_date.upto end_date.to_date do |dt|
        pto_allocations.build( :allocation_date => dt )
      end
      autoassign_pto
    end

end
