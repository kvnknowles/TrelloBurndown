require 'yaml'

class SettingsLoader
  DEFAULT_SIZE = 0
  SMALL_SIZE = 1
  MEDIUM_SIZE = 3
  LARGE_SIZE = 5

  def self.load_sizes(settings_file)
    sizes = Hash.new
    sizes[:default] = DEFAULT_SIZE
    sizes.default = DEFAULT_SIZE
    sizes[DEFAULT_SIZE.to_s.to_sym] = DEFAULT_SIZE
    sizes[:small] = SMALL_SIZE
    sizes[SMALL_SIZE.to_s.to_sym] = SMALL_SIZE
    sizes[:medium] = MEDIUM_SIZE
    sizes[MEDIUM_SIZE.to_s.to_sym] = MEDIUM_SIZE
    sizes[:large] = LARGE_SIZE
    sizes[LARGE_SIZE.to_s.to_sym] = LARGE_SIZE
    ##ack, we need something that builds these that makes sense
    sizes[:S] = SMALL_SIZE
    sizes[:M] = MEDIUM_SIZE
    sizes[:L] = LARGE_SIZE
    begin
      settings = YAML.load_file(settings_file)
      if settings['sizes']
        sizes = settings['sizes']
        if sizes
          sizes[:default] = (settings['default'] || DEFAULT_SIZE)
        end
      end
    rescue Errno::ENOENT
      #no-op
    end
    sizes
  end
end