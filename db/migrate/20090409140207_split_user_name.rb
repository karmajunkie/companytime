class SplitUserName < ActiveRecord::Migration
  def self.up
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    User.reset_column_information
    User.all.each { |u|
      n=u.name.split(' ')
      u.first_name=n[0]
      u.last_name=n[1]
      u.save
    }
    remove_column :users, :name
  end

  def self.down
    add_column :users, :name, :string
    User.reset_column_information
    User.all.each { |u|
      u.name="#{u.first_name} #{u.last_name}"
      u.save
    }
    remove_column :users, :last_name
    remove_column :users, :first_name
  end
end
