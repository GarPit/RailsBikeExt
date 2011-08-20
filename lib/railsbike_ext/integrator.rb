module RailsbikeExt
  class Integrator
    include Singleton
    
    def initialize
      @engines ||= {}
    end
    
    # Registreded Engines for site
    def engines
      @engines
    end
        
    def register(name, route, engine)
      @engines ||= {}
      @engines[name] = {:engine=>engine, :route=>route}
    end
  end
end