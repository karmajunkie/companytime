class User < ActiveRecord::Base
  has_many :work_periods, :order => "start_time asc"
  has_many :timesheets, :order => "start_date desc";
  has_many :grant_allocations
  #has_many :accruals, :through => :timesheets, :order => "effective_date asc"
  has_many :grants, :through => :grant_allocations, :order => "priority asc"

  default_scope :conditions => {:valid_user => true}
  named_scope :clocked_in, :select => "users.*",
    :joins => :work_periods, :conditions => 'work_periods.end_time IS NULL'

  named_scope :clocked_out, lambda{{
    :conditions => ["users.id not in (?)", clocked_in.map(&:id)+ [-1]]
  }}

  def logged_in?
    false
  end
  def clocked_in?
    work_periods.last && work_periods.last.start_time && (work_periods.last.end_time.nil?)
  end
  def current_accrual
    begin
      timesheets.last.ending_accrual 
    rescue NoMethodError
      nil
    end
  end
  def last_clock
    if work_periods.last.nil?
      nil
    elsif work_periods.last.start_time && work_periods.last.end_time.nil?
      work_periods.last.start_time
    else
      work_periods.last.end_time 
    end
    
  end
  def toggle_clock_status
  end
  
  def name
    "#{first_name} #{last_name}"
  end
end
