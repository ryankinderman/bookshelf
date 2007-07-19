require File.dirname(__FILE__) + "/model_test_helper"

class SoftCoverBookTest < Test::Unit::TestCase
  
  def test_single_table_inheritance
    book = new(:soft_cover_book)
    book.save!
    
    book = Book.find(book.id)
    
    assert book.is_a?(SoftCoverBook)
  end
  
end