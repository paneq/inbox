$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "inbox/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "inbox"
  s.version     = Inbox::VERSION
  s.authors     = ["Robert Pankowecki"]
  s.email       = ["robert.pankowecki@gmail.com"]
  s.homepage    = "https://github.com/paneq/inbox"
  s.summary     = "Displays emails sent to the users in action_mailer.delivery_method = :test mode."
  s.description = "Navigate to inbox and check emails that users would recive. Use this in your acceptance tests and stay happy."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2"
  s.add_dependency "rails_autolink", "~> 1.0.9"
  s.add_dependency "premailer", "~> 1.7.3"
  s.add_dependency "nokogiri", "~> 1.5.5"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
end
