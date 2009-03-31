class CreateTimesheets < ActiveRecord::Migration
  def self.up
    create_table :timesheets do |t|
      t.integer :user_id
      t.integer :accrual_id
      t.datetime :period_begin
      t.datetime :period_end

      t.timestamps
    end
  end

  def self.down
    drop_table :timesheets
  end
end
