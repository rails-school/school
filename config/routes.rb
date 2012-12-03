Rs::Application.routes.draw do
  devise_for :users

  resources :places
  resources :answers
  resources :questions
  resources :users
  resources :lessons

  get "about" => "home#about"
  get "calendar" => "home#calendar"
  get "contact" => "home#contact"

  get "l/:slug" => "lessons#show"
  get "l/:slug/whiteboard" => "lessons#show", :whiteboard => true

  post "rsvp/:id" => "attendances#rsvp"
  post "rsvp/:id/:delete" => "attendances#rsvp"

  get "d/:the_date" => "lessons#day"

  mount Contenteditable::Engine => '/contenteditable'

  root :to => 'home#index'
end
