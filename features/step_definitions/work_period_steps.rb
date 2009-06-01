Given "$login is currently clocked in" do |login|
  user=User.find_by_login!(login)
  wp=Factory(:work_period, :user => user, :end_time => nil)
end

When "$login clocks out" do |login|
  visit clockout_user_path(login)
end

When '$login clocks in' do |login|
  visit clockin_user_path(login)
end

Then "I can see that $login is clocked out" do |login|
  visit root_path
  user = User.find_by_login!(login)
  response.should have_tag('#clocked_out_users .name a[href=?]',
    user_path(user), user.name)

end

Then "I can see that $login is clocked in" do |login|
  visit root_path
  user = User.find_by_login!(login)
  response.should have_tag('#clocked_in_users .name a[href=?]',
    user_path(user), user.name)
end
