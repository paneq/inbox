module Inbox
  class Email
    extend   ::ActiveModel::Naming
    extend   ::ActiveModel::Callbacks
    extend   ::ActiveModel::Translation

    include  ::ActiveModel::Conversion
    include  ::ActiveModel::Validations
    include  ::ActiveModel::Validations::Callbacks
    include  ::ActiveModel::MassAssignmentSecurity
#    include  ::ActiveModel::Warnings

    PopularHeaders = [:from, :to, :cc, :bcc, :subject, :body, :reply_to]

    attr_accessible *PopularHeaders

    def initialize(attributes = {})
      self.attributes = attributes
    end

    def attributes=(values)
      values.stringify_keys!
      @attributes = attributes.merge sanitize_for_mass_assignment(values)
    end

    def attributes
      @attributes ||= ActiveSupport::HashWithIndifferentAccess.new
      @attributes.clone
    end

    PopularHeaders.each do |header|
      define_method(header) do
        attributes[header]
      end

      define_method(:"#{header}=") do |value|
        attributes[header]= value
      end
    end

    def persisted?
      false
    end

    def deliver
      body = attributes.delete('body')
      EmailMailer.normal(attributes, body).deliver
    end

  end
end