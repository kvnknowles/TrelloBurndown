require 'yaml'

class SettingsLoader
  DEFAULT_SIZE = 0

  def self.load_sizes(settings_file)
    begin
      settings = YAML.load_file(settings_file)
      sizes = settings['sizes']
      if sizes
        sizes.default = (settings['default_size'] || DEFAULT_SIZE)
      end
    rescue Errno::ENOENT
      sizes = nil
    end
    sizes
  end
end