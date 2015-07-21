require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require 'hashie'
require 'transifex'
require 'shared_spec_setup'

RSpec.configure do |config|
  config.order = 'random'
  config.run_all_when_everything_filtered = false
end
