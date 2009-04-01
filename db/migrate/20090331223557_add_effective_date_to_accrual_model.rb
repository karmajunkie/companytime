class AddEffectiveDateToAccrualModel < ActiveRecord::Migration
  def self.up
    add_column :accruals, :effective_date, :datetime
  end

  def self.down
    remove_column :accruals, :effective_date
  end
end
