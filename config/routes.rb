Rails.application.routes.draw do
  post "/records" => "records#create"
  get "/records/search" => "records#search"
  get "/records/new" => "records#new"
  get "/records/:id/edit" => "records#edit"
  get "/records/:id" => "records#show"
  patch "/records/:id" => "records#update"
  put "/records/:id" => "records#update"
  delete "/records/:id" => "records#destroy"

  get "/" => "homes#index"

  get "/signup" => "users#new"
  get "/login" => "users#login_form"
  post "/users" => "users#create"
  post "/login" => "users#login"
  post "/logout" => "users#logout"
  get "/mypage" => "users#show"

end
