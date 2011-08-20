module RailsbikeExt
  module Liquid
    module Tags
      class Tree < ::Liquid::Tag
        Syntax = /(#{::Liquid::Expression}+)?/

        def initialize(tag_name, markup, tokens, context)
          if markup =~ Syntax
            @source = ($1 || 'page').gsub(/"|'/, '')
            @options = { :id => 'tree', :depth => 1 }
            @template = nil
            markup.scan(::Liquid::TagAttributes) { |key, value| @options[key.to_sym] = value.gsub(/"|'/, '') }
            
            @options[:exclude] = Regexp.new(@options[:exclude]) if @options[:exclude]
          else
            raise ::Liquid::SyntaxError.new("Syntax Error in 'tree' - Valid syntax: sitemap <page|site> <options>")
          end

          super
        end

        def render(context)
          nodes = fetch_entries(context)
          render_nodes(nodes, context)
        end

        private
        
        def render_nodes(nodes, context)
          output = ""
          unless nodes.empty?
            pagedepth = nodes.first.depth
            template = TreeTemplate.where(:name=>@options[:template]).first
            context['tree-template'] = template.templates_in_deptsh
            if template
              context.stack do
                context['tree'] = {}
                context['tree'] = {
                  'nodes' => nodes,
                  'depth' => pagedepth
                }
                output = ::Liquid::Template.parse(context['tree-template'][pagedepth].template).render(context) if context['tree-template'].has_key?(pagedepth)
              end
            end
          end
          output
        end

        # Determines root node for the list
        def fetch_entries(context)
          @current_page = context.registers[:page]

          children = (case @source
          when 'site'     then context.registers[:site].pages.root.minimal_attributes.first # start from home page
          when 'parent'   then @current_page.parent || @current_page
          when 'page'     then @current_page
          else
            context.registers[:site].pages.fullpath(@source).minimal_attributes.first
          end).children_with_minimal_attributes.to_a

          children = children.delete_if { |p| !include_page?(p) }
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

        ::Liquid::Template.register_tag('tree', Tree)
      end
    end
  end
end