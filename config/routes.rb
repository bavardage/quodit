Quodit::Application.routes.draw do
  match "/auth/:provider/callback" => "sessions#create"
  match "/signout" => "sessions#destroy", :as => :signout


  resources :users

  resources :walls do
    resources :quotes
  end


  root :to => "home#index"

end
