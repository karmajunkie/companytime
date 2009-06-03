# == Schema Information
# Schema version: 20090529235331
#
# Table name: users
#
#  id                    :integer(4)      not null, primary key
#  login                 :string(255)
#  holiday_hours         :float           default(0.0)
#  vacation_hours        :float           default(0.0)
#  sick_hours            :float           default(0.0)
#  vacation_accrual_rate :float           default(0.0)
#  sick_accrual_rate     :float           default(0.0)
#  created_at            :datetime
#  updated_at            :datetime
#  first_name            :string(255)
#  last_name             :string(255)
#  valid_user            :boolean(1)      default(TRUE)
#

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
