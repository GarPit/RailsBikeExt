module RailsbikeExt
  module Liquid
    module Tags
      class RenderNode < ::Liquid::Tag
        Syntax = /(#{::Liquid::Expression}+)?/
        
        def initialize(tag_name, markup, tokens, context)
          super
          @slug = ''
          @slug = @template_name.gsub('\'', '') if @template_name
        end
        
        def render(context)
          node = context['node']
          return '' if node.nil?
          return '' if node.children_menu.empty?
          #pagedepth = node.children.first.depth
          pagedepth = node.children.first.depth
          output = ""
          context.stack do
            context['tree'] = {
              'nodes' => node.children_menu,
              'depth' => pagedepth
            }
            context.scopes.last['pdepth'] = context.scopes.last['pdepth'].to_i + 1
            output = ::Liquid::Template.parse(context['tree-template'][pagedepth].template).render(context) if context['tree-template'].has_key?(pagedepth)
          end
          output
        end
        
        # Determines whether or not a page should be a part of the menu
        def include_page?(page)
          if !page.listed? || page.templatized? || !page.published?
            false
          elsif @options[:exclude]
            (page.fullpath =~ @options[:exclude]).nil?
          else
            true
          end
        end
        
      end
      ::Liquid::Template.register_tag('render_node', RenderNode) 
    end
  end
end