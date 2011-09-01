module RailsbikeExt
    module Drops
      module ProxyCollectionExt
        extend ActiveSupport::Concern

        module InstanceMethods

          def collect!(&block)
            self.collection.collect!(&block)
          end
          
          def fulltext_search(query)
            klass = @content_type.contents.klass
            ret = klass.fulltext_search(query)
            p "[debug]: #{ret.length}"
            ret.uniq.flatten
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