require "export_kindle_highlights/version"

require 'bundler/setup'
require 'kindle_highlights'
require 'thor'
require 'json'

module ExportKindleHighlights
  class ExportKindleHighlights < Thor

    desc "highlights EMAIL PASSWORD", "export json"
    def highlights(email_address, password)
      kindleClient = KindleHighlights::Client.new(
        email_address: email_address,
        password: password,
        root_url: 'https://read.amazon.co.jp'
      )

     print JSON.generate(
        kindleClient.books.map { |book|
          book.highlights_from_amazon.map { |h|
            {
              "asin": book.asin,
             "title": book.title,
             "location": h.location,
             "text": h.text
            }
          }
        }.flatten
      )
    end
  end
end
