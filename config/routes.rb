  Rails.application.routes.draw do
  root to:'games#new'
  post 'score', to: 'games#score', as: :score
  get 'new', to: 'games#new', as: :new
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

