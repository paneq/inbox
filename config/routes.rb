Inbox::Engine.routes.draw do
  get "emails/index"

  get "emails/show"

  resources :emails, :only => [:index, :show, :new, :create]
end
