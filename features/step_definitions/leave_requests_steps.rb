Given "$user is on the employee portal" do |user|
  visit "/"
  response.should have_tag("a[href=?]", new_leave_request_path, "New Leave Request")
end

When "$user clicks \"$link\"" do |user, link| 
  click_link "New Leave Request"
end

Then "$user should go to the Leave Request form" do |user|
  response
end

Given "$user is on the Leave Request form" do |user|
  pending
end

When "$user requests an afternoon of Leave for $reason" do |user, reason|
  pending
end

Then "a leave request should be created with a single leave period" do
  pending
end

Then "a new Leave Request should appear in the admin console" do
  pending
end
