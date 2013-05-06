require 'devise'
require 'warden'
require 'sufia'
require "curate/engine"
require 'rails'
require 'simple_form'
require 'roboto'
require 'bootstrap-datepicker-rails'

module Curate

  class Engine < ::Rails::Engine
    engine_name 'curate'

  end

  def self.config(&block)
    @@config ||= Curate::Engine::Configuration.new

    yield @@config if block

    return @@config
  end
end
