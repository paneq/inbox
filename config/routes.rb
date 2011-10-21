Inbox::Engine.routes.draw do

  scope ":mail", :mail => /[^\/]+/ do
    resources :emails, :only => [:index, :show, :new, :create], :id => /[^\/]+/
  end
end
