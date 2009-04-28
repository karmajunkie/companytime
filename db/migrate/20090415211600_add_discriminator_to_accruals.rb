class AddDiscriminatorToAccruals < ActiveRecord::Migration
  def self.up
    add_column :accruals, :discriminator, :string
  end

  def self.down
    remove_column :accruals, :discriminator
  end
end
