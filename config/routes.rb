Rails.application.routes.draw do
  get 'welcome/index'

  root to: 'visitors#index'
end
