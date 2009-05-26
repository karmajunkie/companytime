Given '$login is an employee' do |login|
  Factory(:user, :login => login)
end