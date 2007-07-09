ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.
  
  # Sample of regular route:
  # map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  # map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # You can have the root of your site routed by hooking up '' 
  # -- just remember to delete public/index.html.
  # map.connect '', :controller => "welcome"
  
  # Simple named route
  map.signup_user 'signup', :controller => 'users', :action => 'signup'
  
  # Scoping named routes
  map.with_options :controller => 'users' do |users|
    users.login_user  'users/login', :action => 'login'
    users.logout_user 'users/logout', :action => 'logout'
  end
  
  # RESTful routes
  map.resources :books #,
#    :collection => {
#    },
#    :member => {
#    }
  map.resources :authors

  # Default route
  map.default '', :controller => 'users', :action => 'index'

  # Allow downloading Web Service WSDL as a file with an extension
  # instead of a file named 'wsdl'
  map.connect ':controller/service.wsdl', :action => 'wsdl'

  # Install the default route as the lowest priority.
  map.connect ':controller/:action/:id.:format'
  map.connect ':controller/:action/:id'
end
