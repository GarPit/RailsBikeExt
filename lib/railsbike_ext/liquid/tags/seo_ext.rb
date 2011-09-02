module RailsbikeExt
  module Liquid
    module Tags
      class SeoExt < ::Liquid::Tag
        
        def render(context)
          title = self.value_for(:seo_title, context)
          title = context['page'].title if title.blank?
          title = context.registers[:site].name if title.blank?
          "#{title}"
        end
        
        protected
        
        # Removes whitespace and quote charactets from the input
        def sanitized_string(string)
          string ? string.strip.gsub(/"/, '') : ''
        end

        def value_for(attribute, context)
          object = self.metadata_object(context)
          value = object.try(attribute.to_sym).blank? ? context.registers[:site].send(attribute.to_sym) : object.send(attribute.to_sym)
          self.sanitized_string(value)
        end

        def metadata_object(context)
          context['content_instance'] || context['page']
        end
        
      end
      
      ::Liquid::Template.register_tag('seo_title_ext', SeoExt)
    end
  end
end