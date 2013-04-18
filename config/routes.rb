Portfolio::Application.routes.draw do

  devise_for :admins do
  	get "sign_in" => "devise/sessions#new"
  	get 'logout' => 'devise/sessions#destroy'
  end

  get "users/new"

  resources :posts do
  	resources :comments
  end


get 'home' => 'high_voltage/pages#show', :id => 'home'
get 'about' => 'high_voltage/pages#show', :id => 'about'
get 'contact' => 'high_voltage/pages#show', :id => 'contact'
get 'portfolio' => 'high_voltage/pages#show', :id => 'portfolio'
get 'resume' => 'high_voltage/pages#show', :id => 'resume'

root :to => 'high_voltage/pages#show', :id => 'home'

end
