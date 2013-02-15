TweetScheduler::Application.routes.draw do
  get "welcome/index"

  root :to => 'welcome#index'
  
  resources :users
  resources :posts

  # Authentication
  match 'auth/:provider/callback' => 'sessions#create'
  match 'sign_out', to: 'sessions#destroy', as: 'sign_out'
  match 'sign_in', to: 'welcome#index', as: 'sign_in' # FIXME should redirect to a sign in page, maybe?
  #match 'auth/failure', to: redirect('/')
end
