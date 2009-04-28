class Grant < ActiveRecord::Base
  default_scope :order => "priority ASC"

end
