Rails.application.routes.draw do
  get 'sessions/new'

  get 'events/top'
  resources :infos
  resources :events
  #get 'home/top'
  get '/', to: 'home#top'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
