class User < ActiveRecord::Base
  has_many :work_periods, :order => "start_time asc"
  has_many :accruals, :order => "effective_date desc"
  has_many :timesheets, :order => "period_begin desc";
  has_one :allocation

  def logged_in?
    work_periods.first.start_time && work_periods.first.end_time == nil
  end
end
