module RailsbikeExt
    module Drops
      module ProxyCollectionExt
        extend ActiveSupport::Concern

        module InstanceMethods

          def collect!(&block)
            self.collection.collect!(&block)
          end
          
          def sphinx_search(query, critery)
            klass = @content_type.contents.klass
            ret = klass.sphinx_search(query, critery)
            ret.flatten.uniq
          end
          
          def select(&block)
            self.collection.select(&block)
          end
          
          def collection_name
            @content_type.name
          end
          
          def group_by_field!(fieldname)
            oldcol = self.collection.group_by{|item| item.send(fieldname)}
            res_array = []
            oldcol.each_pair do |k,v| 
              res_array << {"type" => 'header', "content" => k}
              [v].flatten.each do |item|
                res_array << {"type" => 'item', "content" => item}
              end
            end
            
            @collection = res_array
          end
        end
      end
    end
end