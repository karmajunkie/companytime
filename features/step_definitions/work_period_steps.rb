Given /^"([^\"]*)" is currently clocked in$/ do |email|
  user=User.find_by_email!(email)
  wp=Factory(:work_period, :user => user, :end_time => nil)
end

When /^"([^\"]*)" clocks out$/ do |email|
  visit clockout_user_path(User.find_by_email(email).login)
end

When /^"([^\"]*)" clocks in$/ do |email|
  visit clockin_user_path(User.find_by_email(email).login)
end

Then /^I can see that "([^\"]*)" is clocked out$/ do |email|
  visit root_path
  user = User.find_by_email!(email)
  response.should have_tag('#clocked_out_users .name a[href=?]',
    user_path(user), user.name)

end

Then /^I can see that "([^\"]*)" is clocked in$/ do |email|
  visit root_path
  user = User.find_by_email!(email)
  response.should have_selector("#clocked_in_users .name a[href='#{user_path(user)}']", :content => user.name)
end
