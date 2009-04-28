class CreateHolidays < ActiveRecord::Migration
  def self.up
    create_table :holidays do |t|
      t.datetime :holiday_date
      t.string :name
      t.boolean :optional

      t.timestamps
    end
  end

  def self.down
    drop_table :holidays
  end
end
