require 'spec_helper'

describe 'vim::bundle' do
  let(:title) { 'test-bundle' }
  let(:params) do
    {
      'owner'   => 'root',
      'repo'    => 'https://github.com/tpope/vim-sensible.git',
      'vim_dir' => '/tmp',
    }
  end

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }
      it {
        is_expected.to contain_vcsrepo("vim bundle: /tmp/bundle/test-bundle").with(
          'ensure'   => 'latest',
          'provider' => 'git',
        )
      }
      it { is_expected.to contain_class('git') }
    end
  end
end

# vim: ts=2 sts=2 sw=2 expandtab
