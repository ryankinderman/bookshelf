class AuthorsController < ApplicationController
  def index
    initialize_index
  end
  
  def create
    @author = Author.new(params[:author])
    if @author.save
      flash[:notice] = "Successfully created author '#{@author.full_name}'"
      redirect_to_index
    else
      flash.now[:error] = "Errors occurred while attempting to create the author"
      render :action => 'new'
    end
  end
  
  def edit
    @author = Author.find(params[:id])
  end
  
  def update
    @author = Author.find(params[:id])
    if @author.update_attributes(params[:author])
      flash[:notice] = "Successfully updated author '#{@author.full_name}'"
      redirect_to_index
    else
      flash.now[:error] = "Errors occurred while attempting to update the author"
      render :action => 'edit'
    end
  end
  
  def destroy
    Author.delete(params[:id])
    flash[:notice] = "Successfully removed author"
    redirect_to_index
  end
  
  private
  
  def redirect_to_index
    initialize_index
    redirect_to :action => 'index'    
  end
  
  def initialize_index
    @authors = Author.find(:all)
  end
end