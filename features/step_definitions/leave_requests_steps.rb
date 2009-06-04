Given "$user is on the employee portal" do |user|
  visit "/"
  response.should have_tag("a[href=?]", new_leave_request_path, "New Leave Request")
end

When "$user clicks \"$link\"" do |user, link| 
  click_link "New Leave Request"
end

Then "$user should go to the Leave Request form" do |user|
  URI.parse(current_url).path.should == new_leave_request_path
end

Given "$user is on the Leave Request form" do |user|
  Factory.create(:user, :login => user)
  visit new_leave_request_path
end

When "$login requests an afternoon of Leave for $reason" do |login, reason|
  user=User.find_by_login(login)
  fill_in("leave_request[reason]", reason)
  fill_in("leave_request[vacation_hours]", 4)
  select( user.name, "leave_request[employee_id]")
  click_button "Save"
end

Then "$login should have a leave request created with a single leave period" do |login|
  user=User.find_by_login(login)
  user.leave_requests.should_not be_empty
end

Then "$login should have a leave request in the admin console" do |login|
  visit "/admin"
  user=User.find_by_login(login)
  response.should have_tag("div.requester", user.name)
  response.should have_tag("div.request li",
     "From #{user.leave_requests.first.leave_periods.first.from_date("%x")} To #{user.leave_requests.first.leave_periods.first.until_date("%x")}")

end
