require_relative '../lib/card'
require_relative '../lib/board'
require_relative '../lib/burndown'
require_relative '../lib/trello_extractor'
require_relative '../lib/trello_wrapper'
require_relative '../lib/settings_loader'

require 'fakefs/spec_helpers'

RSpec.configure do |config|
  config.include FakeFS::SpecHelpers, fakefs: true
end