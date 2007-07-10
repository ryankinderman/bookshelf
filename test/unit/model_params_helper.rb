module ParamsHelper
  
  def create(model_name, differences = {})
    model = Class.get(model_name)
    new_object = new(model_name, differences)
    new_object.save
    assert model.exists?(new_object.id), "Failed to create #{model_name}, reason: #{new_object.errors.full_messages}"
    new_object
  end
  
  def new(model_name, differences = {})
    nil_differences = {}
    differences.each { |key, value| nil_differences[key] = nil if value.nil? }
    model_params = self.send "#{model_name}_params".to_sym, differences
    model = Object.const_get(model_name.to_s.classify)
    new_object = model.send :new, model_params.merge(nil_differences)
    assert_not_nil new_object
    new_object
  end

  def params(differences = {})
    raise "Use model_params, not params"
  end
  
  def book_params(differences = {})
    {
      :title => "Test Title",
      :author_id => differences.include?(:author_id) ? differences.delete(:author_id) : Author.create!(:first_name => "Bob", :last_name => "Bilbo").id
    }.merge(differences)
  end
  
  def author_params(differences = {})
    {
      :first_name => "First",
      :last_name => "Last"
    }.merge(differences)
  end
  
  private
  
  def next_unique_integer
    $unique_counter ||= -1
    $unique_counter += 1
  end
  
  def upload_file(path, content_type, filename)
    temp_file = Tempfile.new("test_file");
    temp_file.binmode
    FileUtils.copy_file(path, temp_file.path)
    (class << temp_file; self; end).class_eval do
      alias local_path path
      define_method(:file_name) { File.basename(filename) }
      define_method(:original_filename) { filename }
      define_method(:content_type) { content_type }
    end
    return temp_file
  end
end
Test::Unit::TestCase.send :include, ParamsHelper
