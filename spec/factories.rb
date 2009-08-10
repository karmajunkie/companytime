Factory.define :timesheet do |ts|
end


Factory.sequence(:username) {|i| "user#{i}" }

Factory.define :user do |u|
  u.login { Factory.next(:username) }
  u.first_name {|user| user.login }
  u.last_name 'Smith'
  u.holiday_hours 0
  u.vacation_hours 0
  u.sick_hours 0
  u.vacation_accrual_rate 7
  u.sick_accrual_rate 8
  u.valid_user 1
	u.password 'password'
	u.email {|user| "#{user.first_name}.#{user.last_name}@example.com".downcase!}
	u.email_confirmed true
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
  lr.reason "Vacation"
  lr.vacation_hours  0
  lr.holiday_hours 0
  lr.sick_hours 0
  lr.bereavement false
  lr.bereavement_hours 0
  lr.military false
  lr.military_hours 0
  lr.comp_hours 0
  lr.jury_duty false
  lr.jury_hours 0
  lr.unpaid false
  lr.unpaid_hours 0
  lr.administrative false
  lr.administrative_hours 0
end

Factory.define :leave_type do |m|
	m.sequence(:name){|i| "Leave type #{i}"}
end

Factory.define :leave_period do |lp|
  lp.from_date  Time.zone.now - 3.hours
  lp.until_date Time.zone.now - 1.hour
	lp.leave_request {Factory(:leave_request)}
end

Factory.define :accrual do |m|
	m.effective_date Date.today.beginning_of_month
	m.holiday_hours 0
	m.holiday_time_in_period 0
	m.sick_hours 0
	m.vacation_hours 0
end
Factory.define :timesheet do |m|
	m.start_date Date.today.beginning_of_month
	m.end_date Date.today.end_of_month
	m.association :user, :factory => :user
	m.starting_accrual {|ts| Factory(:accrual, :effective_date => ts.start_date, :discriminator => "start")}
	m.ending_accrual {|ts| Factory(:accrual, :effective_date => ts.end_date, :discriminator => "end")}
end

Factory.define :holiday do |m|
	m.holiday_date Date.today
	m.sequence(:name){|i| "Holiday #{i}"}
	m.optional true
end