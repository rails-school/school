Rs::Application.routes.draw do
  post "polls/answer" => "polls#answer"

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

  post "notify_subscribers/:id" => "users#notify_subscribers", :as => "notify_subscribers"
  post "rsvp/:id" => "attendances#rsvp"
  post "rsvp/:id/:delete" => "attendances#rsvp"
  post "bounce_reports" => "users#report_email_bounce"

  root :to => 'home#index'

  mount Prosperity::Engine => "/metrics"
end
