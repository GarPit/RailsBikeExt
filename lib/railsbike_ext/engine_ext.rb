require 'railsbike_ext/integrator'
require 'railsbike_ext/sphinx_integrator'
module RailsbikeExt
  module EngineExt
    extend ActiveSupport::Concern
    
    module InstanceMethods
      def extension_name(name, route="#")
        self.extension_name(name, route)
      end
    end
    
    module ClassMethods
      def extension_name(name, route)
        ::RailsbikeExt::Integrator.instance.register(name, route, self)
      end
    end
  end
end