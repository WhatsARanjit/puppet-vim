require 'rspec-puppet-utils'
require 'hiera/backend/eyaml'
require 'puppetlabs_spec_helper/module_spec_helper'

RSpec.configure do |c|
 c.hiera_config = 'spec/fixtures/hiera/hiera.yaml'
end
