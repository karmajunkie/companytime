module Timesystem
  def cwday
    wday == 0 ? 7 : wday
  end
end
Time.send :include, Timesystem

 Date::DATE_FORMATS[:month_and_year] = "%B %Y"
 Time::DATE_FORMATS[:month_and_year] = "%B %Y"

