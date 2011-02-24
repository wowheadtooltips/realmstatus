class AddQueueToRealm < ActiveRecord::Migration
  def self.up
    add_column :realms, :queue, :string
  end

  def self.down
    remove_column :realms, :queue
  end
end
