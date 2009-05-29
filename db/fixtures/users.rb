User.seed(:login) do |u|
  u.login                 = 'admin'
  u.holiday_hours         = 0
  u.vacation_hours        = 0
  u.sick_hours            = 0
  u.vacation_accrual_rate = 0
  u.sick_accrual_rate     = 0
  u.first_name            = 'Admin'
  u.last_name             = 'User'
  u.valid_user            = true
end