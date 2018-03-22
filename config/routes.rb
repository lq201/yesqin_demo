Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  root to: 'dashboard#welcome'
  get 'dashboard/welcome'
  get 'dashboard/posts'
  post 'dashboard/send_email'
  post 'dashboard/save_frequency'
  post 'dashboard/send_sms'
end
