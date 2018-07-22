Rails.application.routes.draw do
  get '/api/products/search', to: 'products#search'
end
