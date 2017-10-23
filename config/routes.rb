Rails.application.routes.draw do
  devise_for :users

  root to: "servidores#index"
  get 'servidores/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
