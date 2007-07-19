class AddTypeToBooksTable < ActiveRecord::Migration
  def self.up
    add_column :books, :type, :string
  end

  def self.down
    remove_column :books, :type
  end
end
