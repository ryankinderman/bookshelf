class ChangeAuthorToForeignKeyOnBooksTable < ActiveRecord::Migration
  def self.up
    remove_column :books, :author
    add_column :books, :author_id, :integer
  end

  def self.down
    remove_column :books, :author_id
    add_column :books, :author, :string
  end
end
