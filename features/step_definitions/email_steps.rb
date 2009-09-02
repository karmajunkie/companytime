
Then /^the following users should receive the email:$/ do |table|
  headers = table.headers
  recipients = headers.last.split(',').map{|u| User.find_by_email!(u.strip)} if headers.first == "People"

  recipients.each do |user|
    Then %Q{"#{user.email}" should receive the email:}, table
  end
end

Then /^"([^\"]*)" should receive the email:$/ do |email_address, table|
  find_email(email_address, table).should_not be_nil
end

Then /^"([^\"]*)" should not receive an email$/ do |email|
  find_email(email).should be_nil
end

Then '"$email" should not receive an email with the subject "$subject"' do |email, subject|
  table = Cucumber::Ast::Table.new([['key','value'],['subject', subject]])
  find_email(email, table).should be_nil
end

Then "the following users should not receive any emails" do |table|
	table.raw.each do |user_email|
		user=User.find_by_email!(user_email)
    Then %Q{"#{user.email}" should not receive an email}
  end
end

