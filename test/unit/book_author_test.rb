require File.dirname(__FILE__) + "/model_test_helper"

class BookAuthorTest < Test::Unit::TestCase
  
  def test_belongs_to_book
    book_author = new(:book_author)
    book_author.book = create(:book)
    
    book_author.save!
    book_author = BookAuthor.find(book_author.id)
    
    assert_not_nil book_author.book_id
    assert_equal book_author.book_id, book_author.book.id
  end
  
  def test_belongs_to_author
    book_author = new(:book_author)
    book_author.author = create(:author)
    
    book_author.save!
    book_author = BookAuthor.find(book_author.id)
    
    assert_not_nil book_author.author_id
    assert_equal book_author.author_id, book_author.author.id
  end
  
end