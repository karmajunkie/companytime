When '$login clocks in' do |login|
  visit toggle_user_path(login)
end

Then 'I can see that $login is clocked in' do |login|
  visit root_path
  user = User.find_by_login!(login)
  response.should have_tag('#clocked_in_users .name a[href=?]',
    user_path(user), user.name)
end