require 'spec_helper'
describe 'gigaspaces' do

  context 'with defaults for all parameters' do
    it { should contain_class('gigaspaces') }
  end
end
