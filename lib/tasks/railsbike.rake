# encoding: utf-8

require 'locomotive'

namespace :railsbike do
  
  desc 'export'
  task :export => :environment do
    zipfile = ::Locomotive::Export.run!(current_site, current_site.name.parameterize)
  end
end 