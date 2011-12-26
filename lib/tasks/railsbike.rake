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
  
  desc 'Copy assets to destanation folder'
  task :copy_assets => :environment do
    source = File.join(File.dirname(__FILE__), '..', '..', 'public')
    destination = File.join(Rails.root, 'public')
    #puts "INFO: Mirroring assets from #{source} to #{destination}"
    RailsbikeExt::FileUtilz.mirror_files(source, destination)
  end
end 