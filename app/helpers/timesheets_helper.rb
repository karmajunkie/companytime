module TimesheetsHelper
  def stubbed_timesheet
      ts=stub_model(Timesheet,
          :start_date => Date.today.beginning_of_month,
          :end_date => Date.today.end_of_month,
          :user => stub_model(User, 
              :work_periods => 
                [stub_model(WorkPeriod, :total_hours => 8),
                 stub_model(WorkPeriod, :total_hours => 8)]
          ),
          :starting_accrual => stub_model(Accrual, 
               :vacation_hours => 99, 
               :holiday_hours => 100,
               :sick_hours => 50),
          :ending_accrual => stub_model(Accrual, 
               :vacation_hours => 105,
               :holiday_hours => 108,
               :sick_hours => 60))
      ts.user.work_periods.stub!(:for_month).and_return(ts.user.work_periods)
      ts.user.work_periods.stub!(:total_hours).and_return(ts.user.work_periods)

      ts
  end
end
