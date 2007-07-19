require File.dirname(__FILE__) + '/controller_test_helper'

class BooksControllerTest < Test::Unit::TestCase
  
  def setup
    login_as :quentin
  end
  
  def test_that_index_renders_and_assigns
    get :index

    assert_renders 'index'
    assert_assigns :books
  end
  
  def test_that_new_renders
    get :new

    assert_renders 'new'
  end
  
  def test_that_successful_create_redirects_to_index_with_flash_notice
    form_data = {:title => "Transmission", :author => "Hari Kunzru", :isbn => '978-0525947608'}
    book = stub(:title => form_data[:title])
    Book.expects(:new).with(form_data.stringify_keys).returns(book)
    book.expects(:save).returns(true)
    
    post :create, :book => form_data
    
    assert_redirected :action => 'index'
    assert_flashes :notice
    assert_assigns :books
  end
  
  def test_that_unsuccessful_create_rerenders_with_error
    form_data = {:title => "Transmission", :author => "Hari Kunzru", :isbn => '978-0525947608'}
    book = Book.new
    Book.expects(:new).with(form_data.stringify_keys).returns(book)
    book.expects(:save).returns(false)
    
    post :create, :book => form_data
    
    assert_renders 'new'
    assert_flashes :error, :now => true
  end
  
  def test_that_edit_renders_and_assigns
    book = Book.new
    book.stubs(:id).returns(123)
    Book.expects(:find).with('123').returns(book)
    
    get :edit, :id => 123
    
    assert_renders 'edit'
    assert_assigns :book
  end
  
  def test_that_successful_update_redirects_to_index_and_flashes_notice
    form_data = {:author => "William Gibson"}
    book = Book.new
    Book.expects(:find).with('123').returns(book)
    book.expects(:update_attributes).with(form_data.stringify_keys).returns(true)
    Book.expects(:find).with(:all).returns([])
    
    put :update, :id => 123, :book => form_data
    
    assert_redirected :action => 'index'
    assert_assigns :books
    assert_flashes :notice
  end
  
  def test_that_unsuccessful_update_rerenders_and_flashes_error
    form_data = {:author => "William Gibson"}
    book = Book.new
    book.stubs(:id).returns(123)
    Book.expects(:find).with('123').returns(book)
    book.expects(:update_attributes).with(form_data.stringify_keys).returns(false)
    
    put :update, :id => 123, :book => form_data
    
    assert_renders 'edit'
    assert_assigns :book
    assert_flashes :error, :now => true
  end
  
  def test_that_destroy_redirects_to_index_and_flashes_notice
    Book.expects(:delete).with('123')
    
    delete :destroy, :id => 123
    
    assert_renders 'destroy'
    assert_flashes :notice
  end
  
#  def test_transaction
#    BookAuthor.expects(:save!).returns(false)
#    last_book = Book.find(:first, :order => 'id desc')
#    
#    post :create, :book => {:title => ...}
#    
#    now_last_book = Book.find(:first, :order => 'id desc')
#    assert_equal last_book.id, now_last_book.id
#  end

end