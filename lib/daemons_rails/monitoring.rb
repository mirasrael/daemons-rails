module DaemonsRails
  class Monitoring
    def self.controls_directory=(value)
      @controls_directory = value
    end

    def self.controls_directory
      @controls_directory ||= File.dirname(__FILE__)
    end

    def self.status
      @controls_directory.each do |file|

      end
    end
  end
end