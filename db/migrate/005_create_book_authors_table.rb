class CreateBookAuthorsTable < ActiveRecord::Migration
  def self.up
    create_table :book_authors do |t|
      t.column :book_id, :integer
      t.column :author_id, :integer
    end
    remove_column :books, :author_id
  end

  def self.down
    drop_table :book_authors
    add_column :books, :author_id, :integer
  end
end
