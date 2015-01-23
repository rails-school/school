Rs::Application.routes.draw do

  require "sidekiq/web"

  post "polls/answer" => "polls#answer"

  resources :badges, param: :slug, only: [:index, :show]
  resources :polls
  resources :schools

  devise_for :users, controllers: {sessions: "devise_overrides/sessions"}

  #resources :venues
  # NOTE I just discovered that any user could destroy venues, so have
  # disabled creating, deleting, and updating venues through the website
  # until we lock this down properly
  resources :venues, only: [:index, :show, :edit, :new]
  resources :answers
  resources :questions
  resources :users, :except => [:new, :create, :destroy]
  resources :lessons, :path => "l" do
    member do
      get "whiteboard" => "lessons#show", :whiteboard => true
    end
    resources :notifications, only: [:new, :create]
  end

  %w{lesson badge}.each do |notification_type|
    get "#{notification_type}_unsubscribe/:code" => "users#unsubscribe",
      as: "#{notification_type}_unsubscribe",
      defaults: {notification_type: notification_type}
  end
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

  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web, at: "/sidekiq"
  end
end
