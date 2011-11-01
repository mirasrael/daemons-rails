require 'rake'

desc "Show status of daemons"
task :daemons => "daemons:status"

namespace :daemons do
  %w[start stop status].each do |arg|
    desc "#{arg.capitalize} all daemons."
    task :"#{arg}" do
      puts `script/daemons #{arg}`
    end
  end
end

namespace :daemon do
  Dir['lib/daemons/*_ctl'].each do |controller|
    app_name = controller.sub(/.*\/(\w+)_ctl/, '\1')
    namespace app_name do
      %w[start stop status].each do |arg|
        desc "#{arg.capitalize} #{app_name} daemons."
        task :"#{arg}" do
          puts `#{controller} #{arg}`
        end
      end
    end
  end
end