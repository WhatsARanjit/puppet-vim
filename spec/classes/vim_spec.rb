require 'spec_helper'

describe 'vim', :type => :class do
  context "on a Redhat system" do
    let :facts do
    {
      :kernel   => 'Linux',
      :osfamily => 'Redhat',
      :is_pe    => false,
    }
    end
    it { should contain_class('vim') }
    it { should contain_package('vim-common') }
    it { should contain_package('vim-enhanced') }
  end

  context "on a Debian system" do
    let :facts do
    {
      :kernel   => 'Linux',
      :osfamily => 'Debian',
    }
    end
    it { should contain_class('vim') }
    it { should contain_package('vim-common') }
  end
end
