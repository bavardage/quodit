Quodit::Application.routes.draw do
  match "/auth/:provider/callback" => "sessions#create"
  match "/signout" => "sessions#destroy", :as => :signout


  resources :users do
    member { get 'facebook_friends' }
  end

  resources :walls do
    resources :quotes
    member do
      get 'request_membership'
      get 'autocomplete_member(/:search)', :action => "autocomplete_member", :as => "autocomplete_member"
      get 'invite_facebook/:uid', :action => "invite_facebook"
    end
  end


  root :to => "home#index"

end
