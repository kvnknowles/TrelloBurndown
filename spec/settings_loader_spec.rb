require 'spec_helper'
require 'yaml'
require 'fakefs/safe'

describe SettingsLoader, '#load_sizes' do
  TEST_SETTINGS_FILE = 'settings.yml'

  it 'should return a hash of sizes if yaml has sizes' do
    expectedHash = Hash['s', 1, 'l', 3]
    parsed_yaml = {
        'sizes' => expectedHash
    }
    YAML.should_receive(:load_file).with(TEST_SETTINGS_FILE).and_return parsed_yaml
    SettingsLoader.load_sizes(TEST_SETTINGS_FILE).should eq expectedHash
  end

  it 'should return nil if yaml does not have sizes' do
    YAML.should_receive(:load_file).with(TEST_SETTINGS_FILE).and_return Hash.new()
    SettingsLoader.load_sizes(TEST_SETTINGS_FILE).should eq nil
  end

  it 'should return nil if file does not exist' do
    FakeFS do
      SettingsLoader.load_sizes(TEST_SETTINGS_FILE).should eq nil
    end
  end
end