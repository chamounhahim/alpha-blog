Rails.application.routes.draw do
  #Route for the home page
  root 'pages#home'
  #Route to display about page
  get 'about', to: 'pages#about'

  #This sets the show route for article
  resources :articles, only: [:show]
end
