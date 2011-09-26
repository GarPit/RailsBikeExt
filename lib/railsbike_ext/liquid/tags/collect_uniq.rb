module RailsbikeExt
  module Liquid
    module Tags
      class CollectUniq < ::Liquid::Block
        Syntax = /(#{::Liquid::Expression}+)\s+in\s*(#{::Liquid::VariableSignature}+)/
        
        def initialize(tag_name, markup, tokens, context)
          if markup =~ Syntax
            @collection_name = $1
            @subcollection_name = $2
            @options = {}
            markup.scan(::Liquid::TagAttributes) do |key, value|
              @options[key] = value if key != 'http'
            end
          else
            raise ::Liquid::SyntaxError.new("Syntax Error in 'collect_uniq' - Valid syntax: collect_uniq <collection_name> in <grouped_field> [any params]")
          end
          super
        end
        
        def render(context)
          context.scopes.last[@subcollection_name] ||= []
          context.scopes.last[@subcollection_name] << context[@collection_name] if context[@subcollection_name].select{|i| i._id == context[@collection_name]._id}.empty?
          ''
        end
      end
      ::Liquid::Template.register_tag('collect_uniq', CollectUniq)
    end
  end
end