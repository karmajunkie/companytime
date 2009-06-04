Factory.define :timesheet do |ts|
end


Factory.sequence(:username) {|i| "user#{i}" }

Factory.define :user do |u|
  u.login { Factory.next(:username) }
  u.first_name {|user| user.login }
  u.last_name 'Smith'
  u.holiday_hours 20
  u.vacation_hours 40
  u.sick_hours 60
  u.vacation_accrual_rate 7
  u.sick_accrual_rate 8
  u.valid_user 1
end

Factory.define :work_period do |w|
  w.association :user
  w.start_time { Time.zone.now }
end
reasons=[
          "Planning a vacation",
          "Dog passed away",
          "Tickets to a [UFC Fight|Monster Truck Rally|State Fair|Porn Convention]",
          "Dr Appt"
  ]
Factory.sequence(:leave_reason) do |i|
  reasons.rand
end
Factory.sequence(:hours) { rand(120)}
Factory.define :random_leave_request do |lr|
  lr.association :employee, :factory => :user
  lr.association :executive, :factory => :user
  lr.reason { Factory.next(:leave_reason) }
  lr.vacation_hours { Factory.next(:hours) }
  lr.holiday_hours { Factory.next(:hours) }
  lr.sick_hours {Factory.next(:hours) }
  lr.bereavement false
  lr.bereavement_hours 0
  lr.military false
  lr.military_hours 0
  lr.comp_hours { Factory.next(:hours) }
  lr.jury_duty false
  lr.jury_hours 0
  lr.unpaid false
  lr.unpaid_hours 0
  lr.administrative false
  lr.administrative_hours0
end
Factory.define :leave_request do |lr|
  lr.association :employee, :factory => :user
  lr.association :approver, :factory => :user
  #'lr.association :leave_periods, :factory => :leave_periods
  lr.leave_periods {|periods| [Factory.create(:leave_periods)]}
  lr.reason "Vacation"
  lr.vacation_hours  0
  lr.holiday_hours 0
  lr.sick_hours 0
  lr.bereavement false
  lr.bereavement_hours 0
  lr.military false
  lr.military_hours 0
  lr.comp_hours Factory.next(:hours)
  lr.jury_duty false
  lr.jury_hours 0
  lr.unpaid false
  lr.unpaid_hours 0
  lr.administrative false
  lr.administrative_hours0
end

Factory.define :leave_period do |lp|
  lp.from_date  Date.today
  lp.until_date  Date.today
  lp.from_time  3.hours.ago
  lp.until_time  1.hour
end