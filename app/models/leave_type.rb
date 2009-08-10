# == Schema Information
# Schema version: 20090805190920
#
# Table name: leave_types
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  gl_code    :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

class LeaveType < ActiveRecord::Base
end
