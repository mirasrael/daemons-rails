module Daemons
  module Rails
    class Engine < ::Rails::Engine
      generators do
        require File.expand_path(File.join(::Daemons::Rails.root,'generators', 'daemon_generator.rb'))
      end

      rake_tasks do
        ::Dir.glob(::File.join(::Daemons::Rails.root, 'tasks', '**', '**.rake')) { |file| load(file) }
      end
    end
  end
end
