Given /^the following leave types exist:$/ do |table|
	table.raw.each do |row|
		Factory(:leave_type, :name => row[0], :gl_code => row[1])
	end
end

Given /^"([^\"]*)" is on the employee portal$/ do |user|
  visit "/"
  response.should have_tag("a[href=?]", new_leave_request_path, "New Leave Request")
end

Given /^"([^\"]*)" has a pending leave request with the following info:$/ do |email, table|
	user=User.find_by_email(email) || Factory(:user, :email => email)
	request=Factory.build(:leave_request, :employee => user)
	table.raw.each do |row|
		case row[0]
			when /reason/i
				request.reason=row[1]
			when /leave type/i
				request.leave_type = Factory(:leave_type, :name => row[1])
			when /leave periods/i
				row[1].split(",").map(&:strip).each do |period|
					pstart, pend =period.split("-").map!(&:strip)
					request.leave_periods.build(
							:from_date => Time.zone.parse(pstart),
							:until_date => Time.zone.parse(pend))
				end
		end
	end
	request.save
end

Given "$user is on the Leave Request form" do |user|
  Factory.create(:user, :login => user)
  visit new_leave_request_path
end

When /^I request leave for "([^\"]*)" using "([^\"]*)" time$/ do |reason, type|
	fill_in "Reason", reason
	select type, "Leave Type"
	click_button "Save"
end

When "$login requests an afternoon of Leave for $reason using $type time" do |login, reason, type|
  user=User.find_by_login(login)
  fill_in("leave_request[reason]", reason)
  select "Leave Type", type
  select( user.name, "leave_request[employee_id]")
  click_button "Save"
end

When "$user clicks \"$link\"" do |user, link| 
  click_link "New Leave Request"
end

Then "$user should go to the Leave Request form" do |user|
  URI.parse(current_url).path.should == new_leave_request_path
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

Then /^I should see (\d*) "Pending Leave Requests"$/ do |count|
  Then "I should see #{count} \"Pending Leave Requests\" from \"#{current_user.email}\""
end


Then /^I should see (\d*) "Pending Leave Requests" from "([^\"]*)"$/ do |count, email|
  if count.to_i == 0
	  response.should_not have_selector(".pending_leave_requests .request")
  else
	  response.should have_selector(".pending_leave_requests .request")
  end
  user=User.find_by_email(email)
	user.leave_requests.pending.flatten.size.should == count.to_i
end
