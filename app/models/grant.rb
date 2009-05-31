# == Schema Information
# Schema version: 20090529235331
#
# Table name: grants
#
#  id          :integer(4)      not null, primary key
#  title       :string(255)
#  priority    :integer(4)
#  import_code :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Grant < ActiveRecord::Base
  default_scope :order => "priority ASC"

end
