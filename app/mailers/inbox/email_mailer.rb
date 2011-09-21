module Inbox
  class EmailMailer < ActionMailer::Base
#    default from: "from@example.com"

    def normal(headers, body)
      mail(headers) do |format|
        format.html { render :text => body }
      end
    end
  end
end
