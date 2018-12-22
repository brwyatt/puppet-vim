require 'spec_helper'

describe 'vim::config' do
  let(:title) { '/tmp' }
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
    	  is_expected.to contain_file('/tmp/.vim').with(
    	    'ensure'  => 'directory',
    	    'path'    => '/tmp/.vim',
    	    'owner'   => 'root',
    	    'group'   => 'root',
    	    'mode'    => '0700',
          'purge'   => true,
          'recurse' => true,
          'force'   => true,
    	  )
      }
    	it {
    	  is_expected.to contain_file('/tmp/.vim/autoload').with(
    	    'ensure'  => 'directory',
    	    'path'    => '/tmp/.vim/autoload',
    	    'owner'   => 'root',
    	    'group'   => 'root',
    	    'mode'    => '0775',
          'purge'   => true,
          'recurse' => true,
          'force'   => true,
    	  )
      }
    	it {
    	  is_expected.to contain_file('/tmp/.vim/bundle').with(
    	    'ensure'  => 'directory',
    	    'path'    => '/tmp/.vim/bundle',
    	    'owner'   => 'root',
    	    'group'   => 'root',
    	    'mode'    => '0775',
          'purge'   => true,
          'recurse' => true,
          'force'   => true,
    	  )
      }
    	it {
    	  is_expected.to contain_file('/tmp/.vim/plugin').with(
    	    'ensure'  => 'directory',
    	    'path'    => '/tmp/.vim/plugin',
    	    'owner'   => 'root',
    	    'group'   => 'root',
    	    'mode'    => '0775',
          'purge'   => true,
          'recurse' => true,
          'force'   => true,
    	  )
      }
    	it {
    	  is_expected.to contain_file('/tmp/.vimrc').with(
    	    'ensure' => 'file',
    	    'path'   => '/tmp/.vimrc',
    	    'owner'  => 'root',
    	    'group'  => 'root',
    	    'mode'   => '0640',
    	  ).with_content(
          <<~HEREDOC
            " THIS FILE IS MANAGED BY PUPPET

            " Pathogen
            execute pathogen#infect()
            call pathogen#helptags() " generate helptags for everything in 'runtimepath'
          HEREDOC
        )
    	}

      context 'with vimrc_params' do
        let(:params) do
          super().merge({
            'vimrc_params' => {
              'before' => '" BEFORE',
              'after' => '" AFTER',
            }
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
    	    ).with_content(
            <<~HEREDOC
              " THIS FILE IS MANAGED BY PUPPET

              " BEFORE

              " Pathogen
              execute pathogen#infect()
              call pathogen#helptags() " generate helptags for everything in 'runtimepath'

              " AFTER
            HEREDOC
          )
      	}
      end

    end
  end
end

# vim: ts=2 sts=2 sw=2 expandtab
