require File.dirname(__FILE__) + '/../test_helper'

ActionController::Flash::FlashNow.class_eval do
  def []=(k, v)
    @flash[k] = v
    @flash.instance_variable_set(:@now, true)
    v
  end  
end

ActionController::Flash::FlashHash.class_eval do
  def now?
    @now.nil? ? false : @now
  end
end

class BooksControllerTest < Test::Unit::TestCase
  
  def setup
    @controller = BooksController.new
    class << @controller
      def rescue_action(e); raise e; end
    end
    @request = ActionController::TestRequest.new
    @response = ActionController::TestResponse.new
  end
  
  def test_that_index_renders
    get :index
    
    assert_response :success
    assert_template 'index'
  end
  
  def test_that_new_renders
    get :new
    
    assert_response :success
    assert_template 'new'
  end
  
  def test_that_successful_create_redirects_to_index_with_flash_notice
    form_data = {:title => "Transmission", :author => "Hari Kunzru", :isbn => '978-0525947608'}
    book = stub(:title => form_data[:title])
    Book.expects(:new).with(form_data.stringify_keys).returns(book)
    book.expects(:save).returns(true)
    
    post :create, :book => form_data
    
    assert_response :redirect
    assert_redirected_to :action => 'index'
    assert_not_nil flash[:notice]
  end
  
  def test_that_unsuccessful_create_rerenders_with_error
    form_data = {:title => "Transmission", :author => "Hari Kunzru", :isbn => '978-0525947608'}
    book = mock
    Book.expects(:new).with(form_data.stringify_keys).returns(book)
    book.expects(:save).returns(false)
    
    post :create, :book => form_data
    
    assert_response :success
    assert_template 'new'
    assert_not_nil flash[:error]
    assert flash.now?
  end

end