Rails.application.routes.draw do
  get "shuffle/index"
  get "shuffle/shuffle"
  get "shuffle/show"
  delete "shuffle/destroy"
  root "shuffle#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
