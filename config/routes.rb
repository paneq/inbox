Inbox::Engine.routes.draw do

  scope ":mail", :mail => /[^\/]+/ do
    resources :emails, :only => [:index, :show, :new, :create], :id => /[^\/]+/
  end

  #get "examples/rich_html" # Rails namespace bug
  get "examples/rich_html",      :to => "examples#rich_html"
  get "examples/html_plus_text", :to => "examples#html_plus_text"
  get "examples/html_real_body", :to => "examples#html_real_body"
end
