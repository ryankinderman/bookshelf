require File.dirname(__FILE__) + '/../test_helper.rb'

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

class Test::Unit::TestCase
  include AuthenticatedTestHelper
  fixtures :users

  def setup_with_common_initialization
    matches = self.class.name.match(/(.*Controller)Test/)
    if !matches.nil?
      controller_name = matches[1]
      require controller_name.underscore
      controller = controller_name.constantize
      if @rescue_action_defined.nil?
        @rescue_action_defined = true
        controller.class_eval do
          def rescue_action(e); raise e; end
        end
      end
      @controller = controller.new
      @request = ActionController::TestRequest.new
      @response = ActionController::TestResponse.new
    end
  end
  if method_defined?(:setup)
    alias_method :setup_before_common_initialization, :setup
  end
  alias_method :setup, :setup_with_common_initialization
  
  def self.method_added(method)
    if method.to_s == 'setup'
      unless method_defined?(:setup_without_common_initialization)
        alias_method :setup_without_common_initialization, :setup
        if method_defined?(:setup_before_common_initialization)
          define_method(:setup) do
            setup_before_common_initialization
            setup_with_common_initialization
            setup_without_common_initialization
          end
        else
          define_method(:setup) do
            setup_with_common_initialization
            setup_without_common_initialization
          end
        end
      end
    end
  end

  def assert_assigns(assign)
    assert_not_nil assigns(assign), "Expected action #{controller_action} to assign @#{assign}"
  end
  
  def assert_flashes(id, options = {})
    now = options.include?(:now) ? options[:now] : false
    assert_not_nil flash[id]
    assert flash.now? if now
  end
  
  def assert_renders(template)
    assert_response :success
    assert_template template
  end
  
  def assert_redirected(options)
    assert_response :redirect
    assert_redirected_to options
  end
  
  def controller_action
    @controller.class.to_s + "." + @controller.action_name
  end

end