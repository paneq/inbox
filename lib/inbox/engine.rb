module Inbox
  class Engine < Rails::Engine
    isolate_namespace Inbox

    config.after_initialize do
      ActionMailer::Base.add_delivery_method :inbox, Inbox::FileDelivery, Rails.root.join("tmp/mails")
    end
  end
end
