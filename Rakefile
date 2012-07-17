# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project'

require 'bundler/setup'
require 'bubble-wrap'
require 'bubble-wrap/rss_parser'

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'Octodex'

  app.provisioning_profile = ENV['OCTODEX_PROVISIONING_PROFILE'] || "Error"
  app.codesign_certificate = ENV['OCTODEX_CODESIGN_CERTIFICATE'] || ""
end
