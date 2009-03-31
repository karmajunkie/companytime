class CreateAccruals < ActiveRecord::Migration
  def self.up
    create_table :accruals do |t|
      t.integer :user_id
      t.float :vacation_hours
      t.float :holiday_hours
      t.float :sick_hours

      t.timestamps
    end
  end

  def self.down
    drop_table :accruals
  end
end
