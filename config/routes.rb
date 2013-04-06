Portfolio::Application.routes.draw do

get 'pages/home' => 'high_voltage/pages#show', :id => 'home'
get 'pages/about' => 'high_voltage/pages#show', :id => 'about'
get 'pages/contact' => 'high_voltage/pages#show', :id => 'contact'
get 'pages/portfolio' => 'high_voltage/pages#show', :id => 'portfolio'
get 'pages/resume' => 'high_voltage/pages#show', :id => 'resume'

root :to => 'high_voltage/pages#show', :id => 'home'
end
