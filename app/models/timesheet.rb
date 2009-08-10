# == Schema Information
# Schema version: 20090805190920
#
# Table name: timesheets
#
#  id         :integer(4)      not null, primary key
#  user_id    :integer(4)
#  start_date :date
#  end_date   :date
#  created_at :datetime
#  updated_at :datetime
#

class Timesheet < ActiveRecord::Base
  belongs_to :user
  has_one :starting_accrual, :class_name => "Accrual", :conditions => "discriminator='start'"
  has_one :ending_accrual, :class_name => "Accrual", :conditions => "discriminator='end'"
  has_many :pto_allocations, :dependent => :delete_all
  before_create :ensure_pto_allocations_created
  after_create :credit_holiday_time
  has_many :work_periods, :through => :user, 
    :conditions => ["start_time > ? and start_time < ?", '#{start_date.beginning_of_day}', '#{end_date.end_of_day}']

  validates_presence_of :user
  validates_presence_of :start_date
  validates_presence_of :end_date
  validates_uniqueness_of :start_date, :scope => [:user_id]
  validates_associated :user
  
  private
    def ensure_pto_allocations_created
      start_date.to_date.upto end_date.to_date do |dt|
        pto_allocations.build( :allocation_date => dt )
      end
      #autoassign_pto
      starting=build_starting_accrual({
        :effective_date => start_date,
        :discriminator => "start"
      })
      ending=build_ending_accrual({
        :effective_date => end_date,
        :discriminator => "end"
      })
      if user.current_accrual
        starting_accrual.vacation_hours=user.current_accrual.vacation_hours.to_f
        starting_accrual.sick_hours=user.current_accrual.sick_hours.to_f
        starting_accrual.holiday_hours=user.current_accrual.holiday_hours.to_f
        ending_accrual.vacation_hours=user.current_accrual.vacation_hours.to_f+
          user.vacation_accrual_rate
        ending_accrual.sick_hours=user.current_accrual.sick_hours.to_f+
          user.sick_accrual_rate
        ending_accrual.holiday_hours=starting_accrual.holiday_hours
      else
        starting_accrual.vacation_hours=user.vacation_hours
        starting_accrual.sick_hours=user.sick_hours
        starting_accrual.holiday_hours=user.holiday_hours
        ending_accrual.vacation_hours= user.vacation_hours+user.vacation_accrual_rate
        ending_accrual.sick_hours= user.sick_hours+user.sick_accrual_rate
        ending_accrual.holiday_hours= user.holiday_hours
      end
    end
    def credit_holiday_time
      if !(user.nil? || user.current_accrual.nil?)
        ending_accrual.vacation_hours=user.current_accrual.vacation_hours.to_f+user.vacation_accrual_rate
        ending_accrual.sick_hours=user.current_accrual.sick_hours.to_f+user.sick_accrual_rate
      else
        ending_accrual.vacation_hours= user.vacation_hours+user.vacation_accrual_rate
        ending_accrual.sick_hours= user.sick_hours+user.sick_accrual_rate
        ending_accrual.holiday_hours= user.holiday_hours
      end
      pto_allocations.holidays.each do |holiday|
        starting_accrual.holiday_time_in_period += 8 
      end
      ending_accrual.holiday_hours=starting_accrual.holiday_hours +
				      starting_accrual.holiday_time_in_period 
      starting_accrual.save
      ending_accrual.save
    end


end
