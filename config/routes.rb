Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'fb_webhook', to: 'bot#webhook'
  post 'fb_webhook', to: 'bot#receive_message'
end
