Rails.application.routes.draw do
  get 'talks/index'
  post 'talks/update', to: 'talks#update', as: 'talk_update'

  resources :calendars
  get 'sessions/new'

  get 'events/top'
  resources :infos
  resources :events
  get 'classroom/top/:nen/:room' => 'classroom#top'
  #get 'home/top'
  get '/', to: 'home#top'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
