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
When /^I select "([^\"]*)" as the export date$/ do |export_date|
  date=Date.parse(export_date)
  select(date.year, :from => "Year")
  select(date.strftime("%B"), :from => "Month")
end
Then /^the downloaded file should have the content type "([^\"]*)"$/ do |content_type|
  response.content_type.should == content_type
end
Then /^the file should contain the following information\:$/ do |table|
  response.headers["Content-Disposition"] =~/filename\=\"([^\"]*)\"/

  filename = File.join(Rails.root, 'tmp', $1)
  sheet=Spreadsheet.open(filename).worksheet(0)
  table.raw.each_with_index do |test_row, test_row_index|
    test_row.each_with_index do |val, index|
      sheet[test_row_index, index].strip.should == val
    end
  end
  

end