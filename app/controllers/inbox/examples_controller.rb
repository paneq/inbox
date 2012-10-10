
module Inbox
  class ExamplesController < ApplicationController
    def rich_html
      EmailMailer.rich_html.deliver
      render text: "OK", layout: false
    end
  end
end

