require 'mongoid_fulltext'
module Extensions
  module Sphinx
    extend ActiveSupport::Concern
    
    module InstanceMethods
      def sphinx
        custom_fields.select{|field| %w{string text}.include?(field.kind) }.collect do |field|
          self.send(field._name)
        end.join(' ')
      end
    end
    
    module ClassMethods
      def filters
        _parent
      end
    end
    
    included do
      include Mongoid::FullTextSearch
      
      fulltext_search_in :sphinx
    end
  end
end