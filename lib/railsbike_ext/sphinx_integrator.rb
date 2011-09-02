module RailsbikeExt
  class SphinxIntegrator
    include Singleton
    
    def update_dynamic_search_indexes
      ::ContentType.all.each do |ct|
        begin
          klazz = "ContentContentType#{ct._id}".constantize
          klazz.send(:include, Extensions::Sphinx)
        rescue Exception => e
          p "[ERROR]; #{e.message}"
        end
      end.count
    end
    
    def reindex_all
      ::ContentType.all.each do |ct|
        begin
          klazz = "ContentContentType#{ct._id}".constantize
          klazz.update_ngram_index
        rescue Exception => e
          p "[ERROR]; #{e.message}"
        end
      end.count
    end
    
    
  end
end