Rails.application.routes.draw do
  #Route for the home page
  root 'pages#home'
  #Route to display about page
  get 'about', to: 'pages#about'

  #This sets all the needed routes for articles
  resources :articles
end
