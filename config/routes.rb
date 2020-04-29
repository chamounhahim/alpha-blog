Rails.application.routes.draw do
  #Route for the home page
  root 'pages#home'
  #Route to display about page
  get 'about', to: 'pages#about'

  #Route for signup page
  get 'signup', to: 'users#new'

  #This sets all the needed routes for articles
  resources :articles

  # This sets all the needed routes for users, except for new (it goes to signup)
  resources :users, except: [:new]

  #Route for login page
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'


  
end
