class CreateGrants < ActiveRecord::Migration
  def self.up
    create_table :grants do |t|
      t.string :title
      t.integer :priority
      t.string :import_code

      t.timestamps
    end
  end

  def self.down
    drop_table :grants
  end
end
