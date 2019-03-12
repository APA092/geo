Rails.application.routes.draw do
  root to: 'landing#index'
  post '/', to: 'landing#decode'
end
