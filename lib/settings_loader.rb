require 'yaml'

class SettingsLoader
  def self.load_sizes(settings_file)
    begin
      settings = YAML.load_file(settings_file)
      sizes = settings['sizes']
    rescue Errno::ENOENT
      sizes = nil
    end
    sizes
  end
end