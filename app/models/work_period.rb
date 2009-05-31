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
  validates_presence_of :start_time
  validate_on_create :check_clocked_in

  #all work periods for the month starting on the date given
  named_scope :for_month, lambda { |month|
    {:conditions => ["start_time > ? and start_time < ?", month.beginning_of_month.to_time, month.end_of_month.end_of_day.to_time] }
  }
  named_scope :for_day, lambda { |day|
    { :conditions => ["start_time > ? and start_time < ?", day.beginning_of_day.to_time, day.end_of_day.to_time ]}
  }

  named_scope :total_hours, lambda { |period|
    date_formats={ :month => "%m/%Y", :day => "%m/%d/%Y" }
      {:select => " date_format(start_time, '#{date_formats[period]}') as date_worked, round(sum(unix_timestamp(end_time)-unix_timestamp(start_time))/360.0)/10.0 as total_hours",:group => "date_worked"}
  }

  def hours
    if self.start_time 
      self.end_time||= DateTime.now
      diff = self.end_time.to_datetime - self.start_time.to_datetime
      hrs, mins, secs, frac = Date.day_fraction_to_time(diff)
      hrs + (((mins / 60.0) * 10).round(2) / 10)
    else
      nil
    end
  end
  def to_label
    "#{user.name}, #{start_time.localtime.strftime("%x %X")} to #{end_time.localtime.strftime("%x %X")}"
  end
  
private
  
  def check_clocked_in
    errors.add_to_base 'You are already clocked in.' if user.clocked_in?
  end
  
end
