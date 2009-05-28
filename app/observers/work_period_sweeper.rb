class WorkPeriodSweeper < ActionController::Caching::Sweeper
  observe :work_period
  
  def after_save(work_period)
    expire_fragment :clocked_in
  end
end