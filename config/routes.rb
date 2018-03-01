Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show, :index]
  
  get 'tags/index'

  get 'posts/autocomplete'
  #get 'gallery/index'#, as: "gallery"
=begin
  controller :gallery do
  	get "gallery" => :index
  end
=end
  resources :posts do
  	resources :comments
	end

  resources :tags 
  resources :tag_aliases

  root "posts#index"


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #match '/users/:id', to: 'users#show', via: 'get'
  match "*path", to: "application#catch_404", via: :all
end
