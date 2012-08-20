require 'mail'
require 'pathname'

module Inbox
  class EmailsController < ApplicationController

    layout 'inbox/inbox'
    before_filter do
      @mail = params[:mail]
      deliveries = case ActionMailer::Base.delivery_method
      when :test
        Mail::TestMailer.deliveries
      when :inbox
        # Inbox.deliveries ?
        location = ActionMailer::Base.inbox_settings[:location]
        location.each_child(false).map do |email_pathname|
          Mail.read( location.join(  email_pathname  ) )
        end
      else
        raise "ArgumentError"
      end

      @emails = deliveries.select{|e| Array.wrap(e.to).any?{|m| m.include?(@mail) } }.reverse
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

  end
end
