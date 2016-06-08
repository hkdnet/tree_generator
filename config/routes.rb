Rails.application.routes.draw do
  root controller: 'home', action: 'index'
  get 'home/index'
  resources :trees

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
