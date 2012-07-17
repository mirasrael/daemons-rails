require "spec_helper"
require "daemons/rails/configuration"
require "daemons/rails/monitoring"
require "daemons/rails"

describe Daemons::Rails::Configuration do
  around :each do |example|
    Daemons::Rails.configure do |c|
      c.daemons_directory = Rails.root.join('daemons')
    end
    example.run
    Daemons::Rails.configure do |c|
      c.daemons_directory = nil
    end
  end

  it "should override daemons directory" do
    Daemons::Rails::Monitoring.daemons_directory.should == Rails.root.join('daemons')
    Daemons::Rails::Monitoring.controllers.map(&:app_name).should == %w(test2.rb)
  end
end