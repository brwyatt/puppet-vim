require 'spec_helper'

describe 'vim::install' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      name = case os_facts[:os]['family']
             when 'Debian'
               'vim-nox'
             else
               nil
             end

      it { is_expected.to compile }
      it {
        is_expected.to contain_package('vim').with(
          'ensure' => 'latest',
          'name'   => name,
        )
      }

      context 'with package_name' do
        let(:params) { { 'package_name' => 'vim-nox-py2' } }

        it {
          is_expected.to contain_package('vim').with(
            'ensure' => 'latest',
            'name'   => 'vim-nox-py2',
          )
        }
      end

      context 'with package_ensure' do
        let(:params) { { 'package_ensure' => 'purged' } }

        it {
          is_expected.to contain_package('vim').with(
            'ensure' => 'purged',
            'name'   => name,
          )
        }
      end

      context 'with package_name and package_ensure' do
        let(:params) { { 'package_ensure' => 'purged', 'package_name' => 'vim-nox-py2' } }

        it {
          is_expected.to contain_package('vim').with(
            'ensure' => 'purged',
            'name'   => 'vim-nox-py2',
          )
        }
      end
    end
  end
end

# vim: ts=2 sts=2 sw=2 expandtab
