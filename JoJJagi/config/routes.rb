Rails.application.routes.draw do
  get "shuffle/index"
  get "shuffle/shuffle"
  put "shuffle/change"
  get "shuffle/edit"
  delete "shuffle/destroy"
  post "shuffle/sendslack"
  root "shuffle#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
