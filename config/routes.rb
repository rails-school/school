Rs::Application.routes.draw do
  resources :polls

  resources :schools

  devise_for :users

  resources :venues
  resources :answers
  resources :questions
  resources :users, :except => [:new, :create, :destroy]
  resources :lessons, :path => "l" do
    member do
      get "whiteboard" => "lessons#show", :whiteboard => true
    end
  end

  get "unsubscribe/:code" => "users#unsubscribe", :as => "unsubscribe"
  get "about" => "home#about"
  get "calendar" => "home#calendar"
  get "contact" => "home#contact"
  get "faq" => "home#faq"

  post "notify_subscribers/:id" => "users#notify_subscribers"
  post "rsvp/:id" => "attendances#rsvp"
  post "rsvp/:id/:delete" => "attendances#rsvp"

  get "d/:the_date" => "lessons#day"

  mount Contenteditable::Engine => '/contenteditable'

  root :to => 'home#index'
end
