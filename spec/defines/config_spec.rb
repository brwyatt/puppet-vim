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
          <<~HEREDOC
            " Pathogen
            execute pathogen#infect()
            call pathogen#helptags() " generate helptags for everything in 'runtimepath'
          HEREDOC
        )
    	}

      context 'with template_params' do
        let(:params) do
          super().merge({
            'template_params' => {
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
