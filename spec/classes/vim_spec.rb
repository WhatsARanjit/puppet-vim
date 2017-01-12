require 'spec_helper'

describe 'vim', :type => :class do
  context "on a Redhat system" do
    let :facts do
    {
      :kernel => 'Linux',
      :is_pe  => false,
      :os => {
        :family => 'Redhat',
      },
    }
    end
    it { should contain_class('vim') }
    it { should contain_package('vim-common') }
    it { should contain_package('vim-enhanced') }
  end

  context "on a Debian system" do
    let :facts do
    {
      :kernel => 'Linux',
      :os => {
        :family => 'Debian',
      },
    }
    end
    it { should contain_class('vim') }
    it { should contain_package('vim-common') }
  end
end
