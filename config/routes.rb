# frozen_string_literal: true

# == Route Map
#
#         Prefix Verb   URI Pattern                                                                                       Controller#Action
#    disclaimers GET    /disclaimers(.:format)                                                                            disclaimers#index
#                POST   /disclaimers(.:format)                                                                            disclaimers#create
#     disclaimer GET    /disclaimers/:id(.:format)                                                                        disclaimers#show
#                PATCH  /disclaimers/:id(.:format)                                                                        disclaimers#update
#                PUT    /disclaimers/:id(.:format)                                                                        disclaimers#update
#                DELETE /disclaimers/:id(.:format)                                                                        disclaimers#destroy
#    acceptances GET    /acceptances(.:format)                                                                            acceptances#index
#                POST   /acceptances(.:format)                                                                            acceptances#create

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :disclaimers, only: %i[index show create update destroy]
  resources :acceptances, only: %i[index create]
end
