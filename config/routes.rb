Rails.application.routes.draw do
  resources :moderate_tasks
  devise_for :users
  resources :users, only: [:show, :index]
  
  #get 'tags/index'

  get 'posts/autocomplete'
  #get 'panel/index'
  #resources :panel, only: [:index, :posts]

  #get '/panel', to: 'panel#index'
  #get '/panel/posts', to: 'panel#posts'

  resources :posts do
  	resources :comments
	end


  resources :tags 
  resources :tag_aliases
  resources :pools

  root "posts#index"


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #match '/users/:id', to: 'users#show', via: 'get'
  match "*path", to: "application#catch_404", via: :all
end
