require 'rake'

namespace :daemons do
  
  # desc 'Default: status'
  # task :default => :daemons
  
  %w[start stop status].each do |arg|
    desc "#{arg.capitalize} all daemons."
    task :"#{arg}" do
      Dir[File.join Rails.root, "lib", "daemons", "*_ctl"].each {|f| puts `#{f} #{arg}` }
    end
  end
end