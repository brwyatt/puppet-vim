require 'spec_helper'

describe 'vim::configure' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }
    end
  end
end

# vim: ts=2 sts=2 sw=2 expandtab
