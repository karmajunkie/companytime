class WorkPeriod < ActiveRecord::Base
  belongs_to :user

  def hours
    
    if self.start_time 
      endtime = self.end_time || DateTime.now
      diff = endtime - self.start_time.to_datetime
      hrs, mins, secs, frac = Date.day_fraction_to_time(diff)
      hrs + (((mins / 60.0) * 4).round / 4.0)
    else
      nil
    end
  end
end
