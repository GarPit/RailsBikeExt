require 'mongoid_fulltext'
module Extensions
  module Sphinx
    extend ActiveSupport::Concern
    
    module InstanceMethods
      def sphinx
        self.class.fields_names_for_search.collect do |f|
          self.send(f._alias.to_sym)
        end.join(' ')
      end
    end
    
    module ClassMethods
      def fulltext_search_in_dynamic
        fields_names_for_search.each do |cf|
          fulltext_search_in cf._alias.to_sym, :index_name => "#{_parent.slug}.full_index_for.#{cf._alias}", :ngram_width=>4
        end
        fulltext_search_in :sphinx, :ngram_width=>4, :index_name => "#{_parent.slug}.full_index"
      end
      
      def fields_names_for_search
        custom_fields.select{|f| %w{string text}.include?(f.kind)}
      end
      
      def sphinx_search(query_string, options={})
        ret = []
        if options.has_key?(:fields)
          options[:fields].each do |s_field|
            begin
              ret.push(fulltext_search(query_string, :index => "#{_parent.slug}.full_index_for.#{s_field}"))
            rescue Exception => e
            end
          end
          return ret.uniq
        end
        unless options.has_key?(:index)
          options[:index] = "#{_parent.slug}.full_index"
        end
        
        ret = fulltext_search(query_string, options)
      end
    end
    
    included do
      include Mongoid::FullTextSearch
      
      fulltext_search_in_dynamic
    end
  end
end