require 'spec_helper'
require 'daemons/rails/configuration'
require 'daemons/rails/monitoring'
require 'daemons/rails'

describe Daemons::Rails::Configuration do
  subject { Daemons::Rails.configuration }

  describe 'Default configuration' do
    describe 'rails env' do
      it { expect(subject.app_root).to eq Rails.root }
      it { expect(subject.daemons_path).to eq Rails.root.join('lib', 'daemons') }
    end

    describe 'no rails' do
      before(:each) do
        Object.const_set :Rails_, Rails
        Object.send :remove_const, :Rails
      end

      after(:each) do
        Object.const_set :Rails, Rails_
        Object.send :remove_const, :Rails_
      end

      it { expect(subject.app_root).to eq Rails_.root }
      it { expect(subject.daemons_path).to eq Rails_.root.join('lib', 'daemons') }
    end
  end

  describe 'Overridden daemons directory' do
    around :each do |example|
      Daemons::Rails.configure do |c|
        c.daemons_path = Rails.root.join('daemons')
      end
      example.run
      Daemons::Rails.configure do |c|
        c.daemons_path = nil
      end
    end

    it { expect(subject.daemons_path).to eq Rails.root.join('daemons') }

    it 'should override daemons directory' do
      expect(Daemons::Rails::Monitoring.daemons_path).to eq Rails.root.join('daemons')
      expect(Daemons::Rails::Monitoring.controllers.map(&:app_name)).to eq %w(test2.rb)
    end
  end
end
