require "codeclimate-test-reporter"
CodeClimate::TestReporter.start
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'transifex'


require 'simplecov'
require 'coveralls'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]
SimpleCov.start do
  add_group 'lib',        '/lib'
end

require 'hashie'
require 'transifex'
require 'shared_spec_setup'

RSpec.configure do |config|
  config.order = 'random'
  config.run_all_when_everything_filtered = false
end
