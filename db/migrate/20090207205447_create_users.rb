class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name
      t.string :login
      t.float :skeleton_hours, :default => 0.0
      t.float :vacation_hours, :default => 0.0
      t.float :sick_hours, :default => 0.0
      t.float :comp_hours, :default => 0.0
      t.float :vacation_accrual_rate, :default => 0.0
      t.float :sick_accrual_rate, :default => 0.0

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
