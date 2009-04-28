require File.dirname(__FILE__) + "/lib/timesystem_time"
Time.send :include, Timesystem
puts "hello"
