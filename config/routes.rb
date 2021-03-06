Rails.application.routes.draw do

  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "sessions", only: [:create]

  resources :users, controller: "users", only: [:index, :create, :edit, :update, :show] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up/student" => "users#new", as: "sign_up_student"
  get "/sign_up/staff" => "users#new", as: "sign_up_staff"

  get "/dashboard" => "dashboard#index", as: "dashboard"

  get "/redemption" => "dashboard#redeem", as: "redeem"
  post "/redeem_points" => "dashboard#redeem_points", as: "redeem_points"

  get "events/education" => "events#education", as: "education"

  get "events/sport" => "events#sport", as: "sport"

  get "events/other" => "events#other", as: "other"

  get "events/history" => "events#history", as: "history"
  

  get 'faq' => "faq#index", as: "faq"

  resources :events, controller: "events" do
    resources :attendances, only: [:create, :new, :show]
  end

  post '/events/:event_id/attendances/egg' => "attendances#create_egg", as: "event_attendance_egg"

  resources :attendances, only: [:index]

  post '/events/:id/update_loc' => 'events#update_loc', as: 'update_location'

  resources :events, controller: "events" do
    resources :ratings, only: [:create, :new]
  end

end
