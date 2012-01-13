class Rails
  def Rails.root
    @root ||= Pathname.new(File.absolute_path(File.dirname(__FILE__))).join('fixtures')
  end
end

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
end
