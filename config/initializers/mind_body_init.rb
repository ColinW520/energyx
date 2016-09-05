require "#{Rails.application.root}/lib/mind_body_api.rb"

MindBody.configure do |config|
  config.site_ids    = [226360]
  config.source_key  = ENV['MINDBODY_SOURCE_KEY'] || 'test'
  config.source_name = 'EnergyXFitness'
  config.log_level   = :info # Savon logging level. Default is :debug, options are [:debug, :info, :warn, :error, :fatal]
end
# 
# MindBody.configuration.source_name = 'EnergyXFitness' # from MindBody Developer Account (free)
# MindBody.configuration.source_key = ENV['MINDBODY_SOURCE_KEY'] || 'test' # from MindBody Developer Account
# MindBody.configuration.site_ids = [226360] # array of Site IDs - or just 1
