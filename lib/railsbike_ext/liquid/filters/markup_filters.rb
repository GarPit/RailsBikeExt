require 'redcloth'
module RailsbikeExt
  module Liquid
    module Filters
      module MarkupFilters
        def textilize(input)
          RedCloth.new(input).to_html
        end
      end
    end
  end
end

::Liquid::Template.register_filter(RailsbikeExt::Liquid::Filters::MarkupFilters)