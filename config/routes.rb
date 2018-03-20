Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  
  get 'dashboard/welcome'
  post 'dashboard/send_email'
  post 'dashboard/save_frequency'
  post 'dashboard/send_sms'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
