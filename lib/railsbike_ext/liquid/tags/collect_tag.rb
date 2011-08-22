module RailsbikeExt
  module Liquid
    module Tags
      
      # Usage:
      # 
      # {% collect contents.projects by childrens %}
      #   must has 'collection' in this context
      # {% endcollect %}
      #
      class CollectTag < ::Liquid::Block
        
        Syntax = /(#{::Liquid::Expression}+)\s+by\s*(#{::Liquid::VariableSignature}+)/
        
        def initialize(tag_name, markup, tokens, context)
          if markup =~ Syntax
            @collection_name = $1
            @subcollection_name = $2
            @options = {}
            markup.scan(::Liquid::TagAttributes) do |key, value|
              @options[key] = value if key != 'http'
            end
          else
            raise ::Liquid::SyntaxError.new("Syntax Error in 'collect' - Valid syntax: collect <collection_name> by <grouped_field> [any params]")
          end
          super
        end
        
        def render(context)
          context.stack do
            collection = context[@collection_name]
            collection.group_by_field!(@subcollection_name.to_sym)
            context.scopes.last['collection'] = collection
            render_all(@nodelist, context)
          end
        end
        
        protected        
      end
      ::Liquid::Template.register_tag('collect', CollectTag)
      
    end
  end
end