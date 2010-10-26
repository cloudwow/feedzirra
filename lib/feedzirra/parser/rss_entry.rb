module Feedzirra
  
  module Parser
    # == Summary
    # Parser for dealing with RDF feed entries.
    #
    # == Attributes
    # * title
    # * url
    # * author
    # * content
    # * summary
    # * published
    # * categories
    class RSSEntry
      include SAXMachine
      element :title
      element :link, :as => :url
      element "pheedo:origLink", :as => :original_link

      element :"dc:creator", :as => :author
      element :author, :as => :author
      element :"content:encoded", :as => :content
      element :description, :as => :summary

      element :pubDate, :as => :published
      element :pubdate, :as => :published
      element :"dc:date", :as => :published
      element :"dc:Date", :as => :published
      element :"dcterms:created", :as => :published


      element :"dcterms:modified", :as => :updated
      element :issued, :as => :published
      elements :category, :as => :categories

      element :guid, :as => :entry_id
      element "media:thumbnail",:value => :url, :as => :thumbnail
      element "media:thumbnail",:value => :width, :as => :thumbnail_width
      element "media:thumbnail",:value => :height, :as => :thumbnail_height

      element "media:content",:value => :url, :as => :thumbnail
      element "media:content",:value => :width, :as => :thumbnail_width
      element "media:content",:value => :height, :as => :thumbnail_height
include FeedEntryUtilities

      def published
        result =@published || @updated
        if result.is_a? String
          result=@published =parse_datetime(result)
        end
        result
      end
      def updated
        if @updated.is_a? String
          @updated =parse_datetime(@updated)
        end
        @updated
      end

      def original_link
        return CGI.unescapeHTML(@original_link) if @original_link
        return nil
      end
      def link
           self.original_link || @url
      end

    end

  end
  
end
