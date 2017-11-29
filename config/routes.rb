Rails.application.routes.draw do
  resources :posts do
    member do
      put "like", to: "posts#upvote"
      put "dislike", to: "posts#downvote"

    end
    resources :comments do
      member do
        put "like", to: "comments#upvote"
        put "dislike", to: "comments#downvote"
      end
    end
  end
  get '/signup' => 'users#new'
  post '/users' => 'users#create'

  get '/signin' => 'sessions#new'
  post '/signin' => 'sessions#create'
  get '/signout' => 'sessions#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
