class User < ActiveRecord::Base
  has_many :work_periods, :order => "start_time desc"
end
