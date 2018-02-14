Rails.application.routes.draw do
  root 'home#index'

  devise_for :users, :controllers => {
            registrations: 'registrations',
            omniauth_callbacks: 'omniauth_callbacks',
          }, defaults: { format: :json }

  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup
  resources :users, only: [:show], param: :username
  resources :votes, only: [:create, :destroy]
  resources :interests, :contribs
  resources :calendar, only: [:index]

  get '/404', to: 'errors#show', code: '404'
  get '/422', to: 'errors#show', code: '422'
  get '/500', to: 'errors#show', code: '500'
end
