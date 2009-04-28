module Timesystem
  module TimeExtensions
    def cwday
      wday == 0 ? 7 : wday
    end
  end
  module Holidays
    def holiday?
      h=Holiday.find(:first, :conditions => ["holiday_date >= ? and holiday_date <= ?", self.beginning_of_day, self.end_of_day])
      !h.nil?
    end
  end
end

Time.send :include, Timesystem::TimeExtensions
Time.send :include, Timesystem::Holidays
Date.send :include, Timesystem::Holidays
DateTime.send :include, Timesystem::Holidays

Date::DATE_FORMATS[:month_and_year] = "%B %Y"
Time::DATE_FORMATS[:month_and_year] = "%B %Y"
