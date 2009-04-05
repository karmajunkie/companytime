class WorkPeriod < ActiveRecord::Base
  belongs_to :user
  default_scope :order => "start_time asc"

  #all work periods for the month starting on the date given
  named_scope :for_month, lambda { |month|
    {:conditions => ["start_time > ? and start_time < ?", month, ((month>>1)-1)] }
  }

  named_scope :total_hours, :select => " date_format(start_time, '%m/%d/%Y') as date_worked, sum(unix_timestamp(end_time)-unix_timestamp(start_time))/3600.0 as total_hours",:group => "date_worked"

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
