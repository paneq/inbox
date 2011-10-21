require 'mail'

module Inbox
  class EmailsController < ApplicationController

    layout 'inbox/inbox'
    before_filter do
      @mail = params[:mail]
      @emails = Mail::TestMailer.deliveries.select{|e| Array.wrap(e.to).any?{|m| m.include?(@mail) } }.reverse
    end

    def index
      
    end
  
    def show
      @email = @emails.find{|e| e.message_id == params[:id] }
      @body_part = @email

      if @email.multipart?
        content_type = Rack::Mime.mime_type(params[:format] || :html )
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