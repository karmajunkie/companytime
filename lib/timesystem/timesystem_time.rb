module Timesystem
  class_eval <<-EOV
    def cwday
      wday == 0 ? 7 : wday
    end
  EOV
end
