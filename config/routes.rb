Portfolio::Application.routes.draw do

  resources :posts


get 'home' => 'high_voltage/pages#show', :id => 'home'
get 'about' => 'high_voltage/pages#show', :id => 'about'
get 'contact' => 'high_voltage/pages#show', :id => 'contact'
get 'portfolio' => 'high_voltage/pages#show', :id => 'portfolio'
get 'resume' => 'high_voltage/pages#show', :id => 'resume'

root :to => 'high_voltage/pages#show', :id => 'home'
end
