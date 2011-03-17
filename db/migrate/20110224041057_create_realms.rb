class CreateRealms < ActiveRecord::Migration
  def self.up
    create_table :realms do |t|
      t.string :name
      t.string :realmtype
      t.string :population
      t.string :locale
      t.string :status
      t.string :queue
      t.string :flag
      t.datetime :added
    end
  end

  def self.down
    drop_table :realms
  end
end
