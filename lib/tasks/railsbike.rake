# encoding: utf-8

require 'locomotive'

namespace :railsbike do
  
  desc 'export'
  task :export => :environment do
    Site.all.each do |current_site|
      zipfile = ::Locomotive::Export.run!(current_site, current_site.name.parameterize)
      p zipfile
    end
  end
  
  desc 'reindex all models'
  task :reindex => :environment do
    ret = RailsbikeExt::SphinxIntegrator::instance.reindex_all
    p "Reindex compleate... with #{ret}. Bye..."
  end
end 