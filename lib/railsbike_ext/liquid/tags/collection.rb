module RailsbikeExt
  module Liquid
    module Tags
      class CountCollection < ::Liquid::Tag
        Syntax = /(#{::Liquid::Expression}+)/
        
        def initialize(tag_name, markup, tokens, context)
          if markup =~ Syntax
            @collection_name = $1
          else
            raise ::Liquid::SyntaxError.new("Syntax Error in 'count_of' - Valid syntax: count_of <collection>")
          end

          super
        end
        
        def render(context)
          collection = context[@collection_name]
            raise ::Liquid::ArgumentError.new("Cannot count array '#{@collection_name}'. Not found.") if collection.nil?
          "#{collection.size || 0}"
        end
        
      end
      ::Liquid::Template.register_tag('count_of', CountCollection) 
    end
  end
end