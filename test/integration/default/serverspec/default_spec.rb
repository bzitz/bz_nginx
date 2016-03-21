require 'spec_helper'

describe 'nginx::default' do
  describe port (80) do
    it { should be_listening }
    it { should be_listening.with('tcp') }
  end
  describe command ('curl http://localhost') do
    its(:stdout) {should match(/NGINX IS CONFIGURED PROPERLY/)}
  end
  describe package('libpcre3') do
    it {should be_installed}
  end
  describe package('libpcre3-dev') do
    it {should be_installed}
  end
  describe package('libssl-dev') do
    it {should be_installed}
  end
  describe package('libperl-dev') do
    it {should be_installed}
  end
end
