Then 'I can see an error message' do
  response.code.should == '403'
end

Then /^I should not see "(.*)" in the "(.*)" dropdown$/ do |text, label|
  field_labeled(label).element.inner_html.should_not contain(text)
end

Then /^I should explicitly not see "(.*)" in the "(.*)" dropdown$/ do |text, label|
  field_labeled(label).element.children.each do |node|
    node.inner_html.should_not == text
  end
end

Then /^I should see "(.*)" in the "(.*)" dropdown$/ do |text, label|
  field_labeled(label).element.inner_html.should contain(text)
end

Then /^I should explicitly see "(.*)" in the "(.*)" dropdown$/ do |text, label|
  field_labeled(label).element.children.each do |node|
    node.inner_html.should == text
  end
end
Then /^I should see the "([^\"]*)" field$/ do |label|
  response.should have_selector("label", :content => label)
end
When /^I fill in the form with the following info:$/ do |table|
	fill_in_form(table)
end

Then /^I should see an? link to (.*)$/ do |page_name|
  response.should have_selector('a', :content => page_name)
end

Then /^I should not see an? link to (.*)$/ do |page_name|
  response.should_not have_selector('a', :content => page_name)
end

Then /^I should see an? (.*) link$/ do |class_name|
  response.should have_selector('a', :class => ".#{class_name}")
end

Then /^I should not see an? (.*) link$/ do |class_name|
  response.should_not have_selector('a', :class => ".#{class_name}")
end

Then /^I should not see an? "([^\"]+)" button$/ do |button_text|
  response.should_not have_selector('input[type=button]', :content => button_text)
end



When /^I visit (.*) for "([^\"]*)"$/ do |page_name, email|
  visit path_to(page_name, :user =>  User.find_by_email!(email))
end