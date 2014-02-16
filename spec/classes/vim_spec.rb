require 'spec_helper'

describe 'vim', :type => :class do
  context "on a *nix system" do
    let :facts do
    {
      :kernel => 'Linux',
    }
    end
    it { should contain_class('vim') }
    it { should contain_package('vim-common') }
    it { should contain_package('vim-enhanced') }
  end
end
