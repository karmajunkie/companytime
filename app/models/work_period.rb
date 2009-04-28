class WorkPeriod < ActiveRecord::Base
  belongs_to :user
  default_scope :order => "start_time asc"

  #all work periods for the month starting on the date given
  named_scope :for_month, lambda { |month|
    {:conditions => ["start_time > ? and start_time < ?", month.beginning_of_month.to_time, month.end_of_month.end_of_day.to_time] }
  }
  named_scope :for_day, lambda { |day|
    { :conditions => ["start_time > ? and start_time < ?", day.beginning_of_day.to_time, day.end_of_day.to_time ]}
  }

  named_scope :total_hours, lambda { |period|
    date_formats={ :month => "%m/%Y", :day => "%m/%d/%Y" }
      {:select => " date_format(start_time, '#{date_formats[period]}') as date_worked, sum(unix_timestamp(end_time)-unix_timestamp(start_time))/3600.0 as total_hours",:group => "date_worked"}
  }

  def hours
    if self.start_time 
      self.end_time||= DateTime.now
      diff = self.end_time.to_datetime - self.start_time.to_datetime
      hrs, mins, secs, frac = Date.day_fraction_to_time(diff)
      hrs + (((mins / 60.0) * 4).round / 4.0)
    else
      nil
    end
  end
end
