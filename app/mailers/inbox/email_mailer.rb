module Inbox
  class EmailMailer < ActionMailer::Base
#    default from: "from@example.com"

    def normal(headers, body)
      mail(headers) do |format|
        format.text { render :text => body }
      end
    end

    def rich_html
      mail(:to => "example@example.org") do |format|
        format.html { render "rubygems", :layout => false }
      end
    end

    def html_plus_text
      mail(:to => "example@example.org") do |format|
        format.html
        format.text
      end
    end

    def html_real_body
      mail(:to => "example@example.org") do |format|
        format.html
      end
    end

  end
end
