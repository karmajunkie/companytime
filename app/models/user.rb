class User < ActiveRecord::Base
  has_many :work_periods, :order => "start_time asc"
  has_many :timesheets, :order => "start_date desc";
  has_many :grant_allocations
  #has_many :accruals, :through => :timesheets, :order => "effective_date asc"
  has_many :grants, :through => :grant_allocations, :order => "priority asc"

  named_scope :valid_users, :conditions => {:valid_user => true}
  

  def logged_in?
    true
  end
  def clocked_in?
    work_periods.last && work_periods.last.start_time && (work_periods.last.end_time == nil)
  end
  def current_accrual
    begin
      timesheets.last.ending_accrual 
    rescue NoMethodError
      nil
    end
  end
  def name
    "#{first_name} #{last_name}"
  end
end
