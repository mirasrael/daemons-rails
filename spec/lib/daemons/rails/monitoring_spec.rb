require "spec_helper"
require "daemons/rails/monitoring"
require "ostruct"

describe Daemons::Rails::Monitoring do
  [Daemons::Rails::Monitoring, Daemons::Rails::Monitoring.new(Rails.root.join('lib', 'daemons'))].each do |subject|
    it "should get list of controllers" do
      controllers = subject.controllers
      expect(controllers.length).to eq 1
      controller = controllers[0]
      expect(controller.path).to eq Rails.root.join('lib', 'daemons', 'test_ctl')
      expect(controller.app_name).to eq 'test.rb'
    end

    describe "using controllers" do
      before :each do
        @controller = Daemons::Rails::Controller.new(Rails.root.join('lib', 'daemons', 'test_ctl'))
        allow(subject).to receive(:controllers).and_return([@controller])
      end

      it "should return status for all controllers" do
        allow(@controller).to receive(:run).with('status', {}).and_return('test.rb: running [pid 10880]')
        expect(subject.statuses).to eq({'test.rb' => :running})
      end

      it "should start controller by name" do
        allow(@controller).to receive(:run).with('start', {})
        subject.start('test.rb')
      end

      it "should stop controller by name" do
        allow(@controller).to receive(:run).with('stop', {})
        subject.stop('test.rb')
      end
    end
  end

  it "should monitor daemons in other than default directory" do
    expect(Daemons::Rails::Monitoring.new(Rails.root.join('daemons')).controllers.map(&:app_name)).to eq %w(test2.rb)
  end
end
