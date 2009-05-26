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