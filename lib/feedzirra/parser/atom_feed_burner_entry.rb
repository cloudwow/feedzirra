module Feedzirra
  
  module Parser
    # == Summary
    # Parser for dealing with Feedburner Atom feed entries.
    #
    # == Attributes
    # * title
    # * url
    # * author
    # * content
    # * summary
    # * published
    # * categories
    class AtomFeedBurnerEntry
      include SAXMachine
      include FeedEntryUtilities
      element :title
      element :name, :as => :author
      element :link, :as => :url, :value => :href, :with => {:type => "text/html", :rel => "alternate"}
      element :"feedburner:origLink", :as => :url
      element :summary
      element :content
      element :published
      element :id, :as => :entry_id
      element :issued, :as => :published
      element :created, :as => :published
      element :updated
      element :modified, :as => :updated
      elements :category, :as => :categories, :value => :term
      element "pheedo:origLink", :as => :original_link
      element "media:thumbnail",:value => :url, :as => :thumbnail
      element "media:thumbnail",:value => :width, :as => :thumbnail_width
      element "media:thumbnail",:value => :height, :as => :thumbnail_height

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
