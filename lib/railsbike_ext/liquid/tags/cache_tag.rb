module RailsbikeExt
  module Liquid
    module Tags
      
      class CacheTag < ::Liquid::Block
        
        Syntax = /(#{::Liquid::Expression}+)\s+expires_in\s*(#{::Liquid::VariableSignature}+)/
        def initialize(tag_name, markup, tokens, context)  
          if markup =~ Syntax
            @fragment_name = $1
            @expires_in = ($2 || 0).to_i
            @options = {}
            markup.scan(::Liquid::TagAttributes) do |key, value|
              @options[key] = value if key != 'http'
            end
          else
            raise ::Liquid::SyntaxError.new("Syntax Error in 'cache' - Valid syntax: cache <fragment_name> expires_in <expires_time> [any params]")
          end
          super
        end
        
        
        def render(context)
          render_all_and_cache_it(context)
        end
        
        protected
        
        def render_all_and_cache_it(context)
          # try to search name. If if is not variable, then it is text_value as name
          @fragment_name = context[@fragment_name] || @fragment_name
          # and create hash for this
          @fragment_name = Digest::SHA1.hexdigest(@fragment_name)
          Rails.cache.fetch(@fragment_name, :expires_in => @expires_in, :force => @expires_in == 0) do
            context.stack do
              render_all(@nodelist, context)
            end
          end
        end
        
      end
      ::Liquid::Template.register_tag('cache', CacheTag)
    end
  end
end