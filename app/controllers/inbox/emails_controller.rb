require 'mail'
require 'pathname'
require 'rails_autolink/helpers'

module Inbox
  class EmailsController < ApplicationController

    layout 'inbox/inbox'
    helper_method :html_part?

    before_filter do
      @mail = params[:mail]
      mailer = case ActionMailer::Base.delivery_method
      when :test
        Mail::TestMailer
      when :inbox
        Inbox::FileDelivery.new ActionMailer::Base.inbox_settings
      else
        raise "ArgumentError"
      end

      @emails = mailer.deliveries.select{|e| Array.wrap(e.to).any?{|m| m.include?(@mail) } }.reverse
    end

    def index

    end

    def show
      @email = @emails.find{|e| e.message_id == params[:id] }
      @body_part = @email

      if @email.multipart?
        format = "." + (params[:format] || :html).to_s
        content_type = Rack::Mime.mime_type(format)
        @body_part = @email.parts.find { |part| part.content_type.match(content_type) } || @email.parts.first
      end

      @body_part.body = HtmlExtraction.new(@body_part.body).converted_body if html_part?
    end

    def new
      @email = Email.new()
    end

    def create
      @email = Email.new(params[:email])
      if @email.valid?
        @email.deliver
        redirect_to :action => :index
      else
        render :new
      end
    end

    private

    def html_part?
      @body_part.content_type && @body_part.content_type.match(/text\/html/)
    end

  end
end
