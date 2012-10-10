
module Inbox
  class ExamplesController < ApplicationController
    def rich_html
      EmailMailer.rich_html.deliver
      render :text => "OK", :layout => false
    end

    def html_plus_text
      EmailMailer.html_plus_text.deliver
      render :text => "OK", :layout => false
    end
  end
end

