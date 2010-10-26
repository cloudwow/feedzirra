module Feedzirra
  
  module Parser
    # == Summary
    # Parser for dealing with Atom feed entries.
    #
    # == Attributes
    # * title
    # * url
    # * author
    # * content
    # * summary
    # * published
    # * categories
    class AtomEntry
      include SAXMachine
      include FeedEntryUtilities
      element :title
      element :link, :as => :url, :value => :href, :with => {:type => "text/html", :rel => "alternate"}
      element :name, :as => :author
      element :content
      element :summary
      element :published
      element :id, :as => :entry_id
      element :created, :as => :published
      element :issued, :as => :published
      element :updated
      element :modified, :as => :updated
      elements :category, :as => :categories, :value => :term
      elements :link, :as => :links, :value => :href
      element "pheedo:origLink", :as => :original_link
      element "media:thumbnail",:value => :url, :as => :thumbnail
      element "media:thumbnail",:value => :width, :as => :thumbnail_width
      element "media:thumbnail",:value => :height, :as => :thumbnail_height
      def url
        @url || links.first
      end

      
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

      def link
        @original_link || @url
      end

    end

  end
  
end
