Rs::Application.routes.draw do

  require "sidekiq/web"

  post "polls/answer" => "polls#answer"

  resources :badges, param: :slug, only: [:index, :show]
  resources :polls
  resources :schools
  resources :job_posts

  disable_new_user_registrations = Rails.env.production?

  if disable_new_user_registrations
    devise_for :users,
      controllers: {sessions: "devise_overrides/sessions"},
      skip: [:registrations]

    # https://stackoverflow.com/a/31779657/283398
    resource :users,
      only: [:edit, :update, :destroy],
      controller: 'devise/registrations',
      as: :user_registration do
        get 'cancel'
        get 'new' => redirect("/"), as: :new
      end
  else
    devise_for :users, controllers: {sessions: "devise_overrides/sessions"}
  end

  #resources :venues
  # NOTE I just discovered that any user could destroy venues, so have
  # disabled creating, deleting, and updating venues through the website
  # until we lock this down properly
  resources :venues, only: [:index, :show, :edit, :new]
  resources :answers
  resources :questions
  resources :users, except: [:new, :create, :destroy] do
    collection do
      put "device-token" => "users#save_device_token"
    end
  end

  resources :lessons, :path => "l" do
    member do
      get "whiteboard" => "lessons#show", :whiteboard => true
    end
    collection do
      get "future/slugs(/:school_id)", to: "lessons#future_lessons_slug",
                                       as: :future_slug
      get "upcoming(/:school_id)", to: "lessons#upcoming", as: :upcoming
    end
    resources :notifications, only: [:new, :create]
  end
  get "attending_lesson/:lesson_slug", to: "lessons#attending_lesson",
                                       as: :attending_lesson

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

  # handle SendGrid bounces. For some reason they're sending this as get
  get "bounce_reports" => "users#report_email_bounce"
  post "bounce_reports" => "users#report_email_bounce"

  root :to => 'home#index'

  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web, at: "/sidekiq"
  end
end
