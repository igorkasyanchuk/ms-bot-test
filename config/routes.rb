Rails.application.routes.draw do
  post 'bot/webhook', to: 'bot#webhook'
end
