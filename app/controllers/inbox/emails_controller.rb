require 'mail'

module Inbox
  class EmailsController < ApplicationController
    def index
      @emails = Mail::TestMailer.deliveries
    end
  
    def show
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
