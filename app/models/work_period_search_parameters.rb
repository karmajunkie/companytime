class WorkPeriodSearchParameters< ActiveRecord::Base
  def self.columns
    @columns ||= []
  end
  def self.column(name, sql_type = nil, default = nil, null = true)
    columns << ActiveRecord::ConnectionAdapters::Column.new(name.to_s, default, sql_type.to_s, null)
  end

  def user
	  user_id=read_attribute(:user_id)
	  unless user_id.blank?
	    @user||= User.find(user_id)
	  else
		  nil
	  end
  end
  def user=(newuser)
	  write_attribute(:user_id, newuser.id)
	  @user=newuser
  end
  def start_date=(sd)
	  write_attribute(:start_date, sd.to_date)
  end
  def end_date=(ed)
	  write_attribute(:end_date, ed.to_date)
  end
  
  column :user_id, :integer
  column :start_date, :date
  column :end_date, :date

end