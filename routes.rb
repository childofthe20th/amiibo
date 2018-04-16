Rails.application.routes.draw do
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

    get '/amiibo', to: 'amiibo#index'
    get '/amiibo/:id', to: 'amiibo#show'
    post '/amiibo', to: 'amiibo#create'
    delete '/amiibo/:id', to: 'amiibo#delete'
    put '/amiibo/:id', to: 'amiibo#update'
end
