Given /a user named "([^\"]*)"$/ do |name|
  first_name, last_name = name.split
  User.find_by_first_name_and_last_name(first_name, last_name) ||
    Factory(:user, :first_name => first_name, :last_name => last_name)
end



Given 'the following users exist:' do |table|
  table.raw.each do |row|
	  if row[0] == 'admin'
		  Given "\"#{row[1]}\" is an admin"
	  else
		  Given "\"#{row[1]}\" is a user"
	  end
  end
end

Given /^I am logged in as "([^\"]*)"$/ do |email|
  user = User.find_by_email!(email)
  login_as user
end
Given /^"([^\"]*)" is a user$/ do |user|
  Factory(:user, :email => user, :email_confirmed => true)
end

Given /^"([^\"]*)" is an admin$/ do |user|
  Factory(:user, :email => user, :admin => true, :email_confirmed => true)
end

Given /^I have confirmed my account for "([^\"]*)"$/ do |email|
  User.find_by_email!(email).confirm_email!
end

Given /^"([^\"]*)" is an unconfirmed user$/ do |email|
  Factory(:user, :email => email, :email_confirmed => false)
end

When /^I sign up for an account as "([^\"]*)"$/ do |email|
  visit new_user_path
  fill_in_user_signup_form("Email" => email)
  click_button "Save"
end

When /^I create a user account with the following info:$/ do |table|
  visit new_admin_user_path
  fill_in_user_signup_form(table)
  click_button "Save"
end


When 'I signup for an account with the following info:' do |table|
  visit new_user_path
  fill_in_user_signup_form(table)
  click_button 'Save'
end

When /^I log in as "([^\"]*)"$/ do |user_email|
  login_as User.find_by_email!(user_email)
end

When /^"([^\"]*)" clicks the confirmation link in the email$/ do |user_email|
  email = ActionMailer::Base.deliveries.last
  user = User.find_by_email!(user_email)
  link = user_confirmation_url(user, user.token, :host => HOST)
  email.body.should contain(link)
  visit link
end

Then /^I should see (.*) for "([^\"]*)"$/ do |page, user_email|
	URI.parse(current_url).path.should == path_to(page, :user => User.find_by_email!(user_email))
end
