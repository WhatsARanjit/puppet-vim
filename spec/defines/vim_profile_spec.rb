require 'spec_helper'

describe 'vim::vim_profile', :type => :define do
  let :pre_condition do
    'class { "vim": }'
  end
  let :title do
    'ranjit'
  end
  let :facts do
  {
    :kernel => 'Linux',
    :is_pe  => false,
    :os => {
      :family => 'Redhat',
    },
  }
  end
  describe "laying custom vim files" do
    context "with default params" do
      it { should contain_file("/home/ranjit/.vimrc").with(
        'ensure' => 'file',
        'owner'  => 'ranjit',
        'group'  => 'ranjit'
      ) }
      it "should have puppet-lint" do
        should contain_file("/home/ranjit/.vimrc").with_content %r{puppet-lint}
      end
    end
    context "with change in group param" do
      let :params do
        {
          :vim_group => 'root',
        }
      end
      it { should contain_file("/home/ranjit/.vimrc").with(
        'ensure' => 'file',
        'owner'  => 'ranjit',
        'group'  => 'root'
      ) }
    end
    context "with no puppet-lint" do
      let :params do
        {
          :puppet_lint => false,
        }
      end
      it "should not have puppet-lint" do
        should_not contain_file("/home/ranjit/.vimrc").with_content %r{puppet-lint}
      end
    end
  end
end
