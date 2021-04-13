require 'rubygems'
require 'bundler/setup'
ENV['RACK_ENV'] = 'development' if ENV['RACK_ENV'].nil?
Bundler.require(:default, ENV['RACK_ENV'])

APP_ROOT = Pathname.new(File.expand_path('../../', __FILE__))
APP_NAME = APP_ROOT.basename.to_s
require APP_ROOT.join('lib/api')
Dir["#{ APP_ROOT }/lib/**/*.rb"].each { |file| require file }
Figaro::Application.new(environment: ENV['RACK_ENV'], path: 'config/application.yml').load

