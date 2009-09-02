Given /^"([^\"]*)" is currently clocked in$/ do |email|
  user=User.find_by_email!(email)
  wp=Factory(:work_period, :user => user, :end_time => nil)
end

Given /^"([^\"]*)" has the following work periods:$/ do |user_email, table|
  user=User.find_by_email(user_email)
	table.raw.each do |row|
 		starting_time, ending_time = row[0].split("-").map{|d| Time.zone.parse(d)}
		user.work_periods.create(:start_time => starting_time, :end_time => ending_time)
	end
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

Then /^I should see (\d*) work periods$/ do |count|
	response.should have_selector(".search_results .work_period")
	assigns['work_periods'].flatten.size.should == 2
end
