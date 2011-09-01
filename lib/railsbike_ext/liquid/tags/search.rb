module RailsbikeExt
  module Liquid
    module Tags
      class Search < ::Liquid::Tag
        
        Syntax = /\in\s*\[*(.*)\]/
        
        def initialize(tag_name, markup, tokens, context)
          super
          if markup =~ Syntax
            @collection_array = variables_from_string($1)
            @attributes = {}
            markup.scan(::Liquid::TagAttributes) do |key, value|
              @attributes[key] = value.gsub('\'', '')
            end
          else
            raise ::Liquid::SyntaxError.new("Syntax Error in 'search' - Valid syntax: search in [model1, model2, nodel3] <options (ex: form:'form_snippet', result:'result_snippet'")
          end
        end
        
        def render(context)
          output = ''
          @query = context['params']['q']
          context.stack do
            context.scopes.last['search'] = {}
            output = @query.blank? ? show_form(context) : ([] << show_form(context) << show_result(context)).join('')
          end
          output
        end
        
        def show_form(context)
          context.scopes.last['search']['query'] = @query
          render_snippet(@attributes['form'], context)
        end
        
        def show_result(context)
          context.scopes.last['search']['collection'] = fetch_search_results(@query, context['contents'])
          render_snippet(@attributes['result'], context)
        end
        
        def variables_from_string(markup)
          markup.split(',').collect do |var|
            var =~ /\s*(#{::Liquid::Expression})\s*/
            $1 ? $1 : nil
          end.compact
        end
        
        protected
        
        def fetch_search_results(query, targets)
          search_candidate = @collection_array.first
          begin
            targets["#{search_candidate}"].fulltext_search(query).select{|item| 
              @collection_array.include?(item._parent.slug)
              }.compact.map{|r| r.to_liquid }
          rescue Exception => e
            p "[error]: #{e.message}"
            []
          end
        end
        
        def render_snippet(slug, context)
          ret=""
          if context['site'].present?
            snippet = context['site'].site.snippets.where(:slug => slug).first
            ret = self.refresh(snippet, context) if snippet
          end
          ret
        end
        
        def refresh(snippet, context = {})
          if snippet.destroyed?
            @snippet_id = nil
            @partial = nil
          else
            @snippet_id = snippet.id
            @partial = ::Liquid::Template.parse(snippet.template).render(context)
          end
        end
      end
      ::Liquid::Template.register_tag('search', Search)
    end
  end
end