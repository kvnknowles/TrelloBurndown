require 'spec_helper'
require 'yaml'
require 'fakefs/safe'

describe SettingsLoader, '#load_sizes' do
  let(:test_settings_file) {'settings.yml' }
  let(:default_sizes) { Hash[:default, 0, :small, 1, :medium, 3, :large, 5] }

  it 'should return a hash of sizes if yaml has sizes' do
    expectedHash = Hash['s', 1, 'l', 3]
    parsed_yaml = {
        'sizes' => expectedHash
    }
    YAML.should_receive(:load_file).with(test_settings_file).and_return parsed_yaml
    SettingsLoader.load_sizes(test_settings_file).should eq expectedHash
  end

  it 'should return default structure if yaml does not have sizes' do
    YAML.should_receive(:load_file).with(test_settings_file).and_return Hash.new()
    SettingsLoader.load_sizes(test_settings_file).should include default_sizes
  end

  it 'should return default structure if file does not exist' do
    FakeFS do
      SettingsLoader.load_sizes(test_settings_file).should include default_sizes
    end
  end

  it 'sets default size to whatever yaml sets value to' do
    expectedHash = Hash['s', 1, 'l', 3]
    parsed_yaml = {
        'sizes' => expectedHash,
        'default' => 5
    }
    YAML.should_receive(:load_file).with(test_settings_file).and_return parsed_yaml
    SettingsLoader.load_sizes(test_settings_file)[:default].should eq 5
  end

  it 'sets default size to 0 if yaml file does not set default' do
    expectedHash = Hash['s', 1, 'l', 3]
    parsed_yaml = {
        'sizes' => expectedHash
    }
    YAML.should_receive(:load_file).with(test_settings_file).and_return parsed_yaml
    SettingsLoader.load_sizes(test_settings_file)[:default].should eq 0
  end
end