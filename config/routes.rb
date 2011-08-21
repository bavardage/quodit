Quodit::Application.routes.draw do
  match "/auth/:provider/callback" => "sessions#create"
  match "/signout" => "sessions#destroy", :as => :signout


  resources :users do
    member { get 'facebook_friends' }
  end

  resources :walls do
    resources :quotes
    member { get 'autocomplete_member/:search', :action => "autocomplete_member" }
  end


  root :to => "home#index"

end
