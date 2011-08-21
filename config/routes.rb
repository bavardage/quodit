Quodit::Application.routes.draw do
  match "/auth/:provider/callback" => "sessions#create"
  match "/signout" => "sessions#destroy", :as => :signout


  resources :users


  root :to => "home#index"

end
