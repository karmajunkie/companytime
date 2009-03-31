class User < ActiveRecord::Base
  has_many :work_periods, :order => "start_time desc"
  has_many :accruals, :order => "effective_date desc"
end
