require 'spec_helper'

describe 'vim::config' do
  let(:title) { '/tmp/.vimrc' }
  let(:params) do
    {
      'owner'   => 'root',
    }
  end

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

    	it { is_expected.to compile }
    	it {
    	  is_expected.to contain_file('/tmp/.vimrc').with(
    	    'ensure' => 'file',
    	    'path'   => '/tmp/.vimrc',
    	    'owner'  => 'root',
    	    'group'  => 'root',
    	    'mode'   => '0640',
    	  ).with_content(
          /^\s*execute pathogen#infect\(\) *(".*|)$/
        ).with_content(
          /^\s*call pathogen#helptags\(\) *(".*|)$/
        )
    	}

      context 'with content' do
        let(:params) do
          super().merge({
            'content' => '" test',
          })
        end

      	it { is_expected.to compile }
      	it {
      	  is_expected.to contain_file('/tmp/.vimrc').with(
      	    'ensure' => 'file',
      	    'path'   => '/tmp/.vimrc',
      	    'owner'  => 'root',
      	    'group'  => 'root',
      	    'mode'   => '0640',
      	  ).with_content('" test')
      	}
      end

    end
  end
end

# vim: ts=2 sts=2 sw=2 expandtab
