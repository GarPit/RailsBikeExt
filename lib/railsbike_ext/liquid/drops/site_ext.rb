module RailsbikeExt
  module Drops
    module SiteExt
      extend ActiveSupport::Concern
      
      module InstanceMethods
        def site
          self._source
        end
      end
    end
  end
end