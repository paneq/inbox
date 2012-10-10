require 'premailer'
require 'stringio'
require 'nokogiri'

module Inbox
  class HtmlExtraction

    attr_reader :converted_body

    def initialize(html)
      premailer   = Premailer.new(StringIO.new(html.to_s))
      inline_css  = premailer.to_inline_css
      noko        = Nokogiri::HTML(inline_css)
      noko.search('//script').remove()
      @converted_body = noko.xpath('//body').first.inner_html
    end

  end
end
