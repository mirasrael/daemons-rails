require 'spec_helper'
require 'daemons/rails/monitoring'
require 'ostruct'

describe 'Daemons::Rails::Monitoring' do

  [Daemons::Rails::Monitoring, Daemons::Rails::Monitoring.default, Daemons::Rails::Monitoring.new(Rails.root.join('lib', 'daemons'))].each do |subject|
    # it 'should get list of controllers' do
    #   controllers = subject.controllers
    #   expect(controllers.length).to eq 1
    #   controller = controllers[0]
    #   expect(controller.path).to eq Rails.root.join('lib', 'daemons', 'test_ctl')
    #   expect(controller.app_name).to eq 'test.rb'
    # end

    describe "using controller #{subject}" do
      before(:each) do
        subject.start('test.rb')
      end

      after(:each) do
        subject.stop('test.rb')
      end

      it 'should return status for all controllers' do
        expect(subject.statuses).to eq({'test.rb' => :running})
      end
    end
    # it 'should return status for all controllers' do
    #   expect(subject.statuses).to eq({'test.rb' => :not_exists})
    # end
    # it 'should monitor daemons in other than default directory' do
    #   expect(subject.controllers.map(&:app_name)).to eq %w(test.rb)
    # end
  end

  [Daemons::Rails::Monitoring.new(Rails.root.join('daemons'))].each do |subject|
    # it 'should get list of controllers' do
    #   controllers = subject.controllers
    #   expect(controllers.length).to eq 1
    #   controller = controllers[0]
    #   expect(controller.path).to eq Rails.root.join('daemons', 'test2_ctl')
    #   expect(controller.app_name).to eq 'test2.rb'
    # end

    describe "using controller #{subject}" do
      before(:each) do
        subject.start('test2.rb')
      end

      after(:each) do
        subject.stop('test2.rb')
      end

      it 'should return status for all controllers' do
        expect(subject.statuses).to eq({'test2.rb' => :running})
      end
    end

    # it 'should return status for all controllers' do
    #   expect(subject.statuses).to eq({'test2.rb' => :not_exists})
    # end
    #
    # it 'should monitor daemons in other than default directory' do
    #   expect(subject.controllers.map(&:app_name)).to eq %w(test2.rb)
    # end
  end
end
