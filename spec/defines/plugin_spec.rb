require 'spec_helper'

describe 'vim::plugin' do
  let(:title) { 'test_plugin' }
  let(:params) do
    {
      'owner'   => 'root',
      'vim_dir' => '/tmp',
    }
  end

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      context "with puppet source" do
        let(:params) do
          super().merge({
            'source' => 'puppet:///modules/somemodule/somefile',
          })
        end
        it { is_expected.to compile }
        it { is_expected.not_to contain_remote_file('/tmp/plugin/test_plugin') }
    	  it {
    	    is_expected.to contain_file('/tmp/plugin/test_plugin').with(
    	      'ensure'  => 'file',
    	      'path'    => '/tmp/plugin/test_plugin',
    	      'owner'   => 'root',
    	      'group'   => 'root',
    	      'mode'    => '0640',
            'source'  => 'puppet:///modules/somemodule/somefile'
    	    )
        }
        it { is_expected.not_to contain_file('/tmp/autoload/test_plugin') }
        context "with autoload" do
          let(:params) do
            super().merge({
              'autoload' => true,
            })
          end
          it { is_expected.to compile }
          it { is_expected.not_to contain_remote_file('/tmp/plugin/test_plugin') }
    	    it {
    	      is_expected.to contain_file('/tmp/plugin/test_plugin').with(
    	        'ensure'  => 'file',
    	        'path'    => '/tmp/plugin/test_plugin',
    	        'owner'   => 'root',
    	        'group'   => 'root',
    	        'mode'    => '0640',
              'source'  => 'puppet:///modules/somemodule/somefile'
    	      )
          }
    	    it {
    	      is_expected.to contain_file('/tmp/autoload/test_plugin').with(
    	        'ensure' => 'link',
    	        'path'   => '/tmp/autoload/test_plugin',
    	        'owner'  => 'root',
    	        'group'  => 'root',
    	        'mode'   => '0777',
              'target' => '/tmp/plugin/test_plugin',
    	      )
          }
        end
      end
 
      context "with https source" do
        let(:params) do
          super().merge({
            'source' => 'https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim',
          })
        end
        it { is_expected.to compile }
        it { is_expected.not_to contain_file('/tmp/plugin/test_plugin') }
    	  it {
    	    is_expected.to contain_remote_file('/tmp/plugin/test_plugin').with(
    	      'ensure'  => 'present',
    	      'path'    => '/tmp/plugin/test_plugin',
    	      'owner'   => 'root',
    	      'group'   => 'root',
    	      'mode'    => '0640',
            'source'  => 'https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim',
    	    )
        }
        it { is_expected.not_to contain_file('/tmp/autoload/test_plugin') }
        context "with autoload" do
          let(:params) do
            super().merge({
              'autoload' => true,
            })
          end
          it { is_expected.to compile }
          it { is_expected.not_to contain_file('/tmp/plugin/test_plugin') }
    	    it {
    	      is_expected.to contain_remote_file('/tmp/plugin/test_plugin').with(
    	        'ensure'  => 'present',
    	        'path'    => '/tmp/plugin/test_plugin',
    	        'owner'   => 'root',
    	        'group'   => 'root',
    	        'mode'    => '0640',
              'source'  => 'https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim',
    	      )
          }
    	    it {
    	      is_expected.to contain_file('/tmp/autoload/test_plugin').with(
    	        'ensure' => 'link',
    	        'path'   => '/tmp/autoload/test_plugin',
    	        'owner'  => 'root',
    	        'group'  => 'root',
    	        'mode'   => '0777',
              'target' => '/tmp/plugin/test_plugin',
    	      )
          }
        end
      end
    end
  end
end

# vim: ts=2 sts=2 sw=2 expandtab
