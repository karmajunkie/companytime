# == Schema Information
# Schema version: 20090529235331
#
# Table name: work_periods
#
#  id         :integer(4)      not null, primary key
#  user_id    :integer(4)
#  start_time :datetime
#  end_time   :datetime
#  note       :text
#  created_at :datetime
#  updated_at :datetime
#

class WorkPeriod < ActiveRecord::Base
  belongs_to :user

  default_scope :order => "start_time asc"
  named_scope :current, :conditions => ["start_time < now()"]
  named_scope :starts_after, lambda{|date|
	  unless date.blank?
		  {:conditions => ["start_time > ?", date.beginning_of_day]}
	  end
  }
  named_scope :starts_before, lambda{|date|
	  unless date.blank?
		  {:conditions => ["start_time < ?", date.end_of_day]}
	  end
  }
  named_scope :for_employee, lambda{|user|
	  unless user.blank?
	    {:conditions => {:user_id => user.id}}
	  end
  }

  validates_presence_of :start_time
  validate_on_create :check_clocked_in
  validate :check_overlapping

  #all work periods for the month starting on the date given
  named_scope :for_month, lambda { |month|
    {:conditions => ["start_time >= ? and start_time <= ?", month.beginning_of_month.to_time, month.end_of_month.end_of_day.to_time] }
  }
  named_scope :for_day, lambda { |day|
    { :conditions => ["start_time >= ? and start_time <= ?", day.beginning_of_day.to_time, day.end_of_day.to_time ]}
  }

  named_scope :total_hours, lambda { |period|
    date_formats={ :month => "%m/%Y", :day => "%m/%d/%Y" }
      {:select => " date_format(start_time, '#{date_formats[period]}') as date_worked, round(sum(unix_timestamp(end_time)-unix_timestamp(start_time))/3600.0*4)/4 as total_hours",:group => "date_worked"}
  }

  def hours
    if self.start_time 
      self.end_time||= DateTime.now
      diff = self.end_time.to_datetime - self.start_time.to_datetime
      hrs, mins, secs, frac = Date.day_fraction_to_time(diff)
      hrs + (((mins / 60.0) * 4).round.to_f / 4)
    else
      raise "No start time available"
    end
  end
  def to_label
    "#{user.name}, #{start_time.localtime.strftime("%x %X")} to #{end_time.localtime.strftime("%x %X")}"
  end
  
private
  
  def check_clocked_in
    errors.add_to_base 'You are already clocked in.' if user.clocked_in? && start_time > user.last_clock
  end
	def check_overlapping
		wp=WorkPeriod.find(:first, :conditions => ["start_time < ? and end_time > ? and user_id = ?", start_time, start_time, user_id])
		errors.add_to_base "overlaps with another work period" unless wp.nil?
	end
  
end
