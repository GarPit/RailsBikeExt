source "http://rubygems.org"
# Add dependencies required to use your gem here.
# Example:
#   gem "activesupport", ">= 2.3.5"

# Add dependencies to develop your gem here.
# Include everything needed to run rake, tests, features, etc.
gem 'rails', '3.0.10'
gem 'mongoid', '~> 2.0.2'
gem 'bson_ext', '~> 1.3.0'
gem 'haml', '3.1.2'
gem 'sass', '3.1.2'
gem 'qu-mongo'
gem 'daemon-spawn'

group :development do
  gem "shoulda", ">= 0"
  #gem "bundler", "~> 1.0.0"
  gem "jeweler", "~> 1.6.4"
  gem "rcov", ">= 0"
end

group :test do
  gem 'linecache', '0.43', :platforms => :mri_18
  #gem 'ruby-debug', :platforms => :mri_18
  #gem 'ruby-debug19', :platforms => :mri_19

  gem 'cucumber-rails', '1.0.2'
  gem "pickler", :git=>"git://github.com/tpope/pickler.git"
end

