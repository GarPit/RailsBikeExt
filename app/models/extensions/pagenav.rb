module Extensions
  module Pagenav
    extend ActiveSupport::Concern
    
    module InstanceMethods
      def all_slugs
        fullpath.split('/')
      end
    end
  end
end