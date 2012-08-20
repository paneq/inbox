require "inbox/engine"
require 'fileutils'
require 'pathname'
#require 'securerandom'

module Inbox
  class FileDelivery

    def initialize(values)
      self.settings = { :location => './mails' }.merge(values)
    end

    attr_accessor :settings

    def deliver!(mail)
      FileUtils.mkdir_p location
      location.join(filename = Time.now.to_f.to_s).open("w") do |f|
        f.write mail.encoded
      end
    end

    private

    def location
      settings[:location]
    end
  end

  ActionMailer::Base.add_delivery_method :inbox, Inbox::FileDelivery, :location => Pathname.new("#{Dir.tmpdir}/mails")
end
