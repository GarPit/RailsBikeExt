module RailsbikeExt
    module Drops
      module PageExt
        module ClassMethods
          
        end
        
        module InstanceMethods
          def children_menu
            self._source.children.reject{|p| !include_page?(p)}
          end
          
          def all_slugs
            @all_slugs ||= liquify(*self._source.self_and_ancestors.map{|i| i.slug})
          end
          
          private
          
          def include_page?(page)
            if !page.listed? || page.templatized? || !page.published?
              false
            else
              true
            end
          end
        end
        
        def self.included(receiver)
          receiver.extend         ClassMethods
          receiver.send :include, InstanceMethods
        end
        
      end
      
    end
end