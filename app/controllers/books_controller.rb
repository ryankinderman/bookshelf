class BooksController < ApplicationController
  def index
    initialize_index
  end
  
  def create
    @book = Book.new(params[:book])
    if @book.save
      flash[:notice] = "Successfully created book '#{@book.title}''"
      initialize_index
      redirect_to :action => 'index'
    else
      flash.now[:error] = "Errors were encountered while attempting to create the book"
      render :action => 'new'
    end
  end
  
  private
  
  def initialize_index
    @books = Book.find(:all)
  end
end