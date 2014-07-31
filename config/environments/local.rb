Rails.application.configure do
  config.cache_classes = true 
  config.eager_load = true
  config.consider_all_requests_local       = false 
  config.action_controller.perform_caching = true 

  config.active_support.deprecation = :notify
  
  config.assets.compress = false
  
end
