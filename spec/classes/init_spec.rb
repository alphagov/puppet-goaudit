require 'spec_helper'
describe 'goaudit' do
  let (:facts) {{
    :osfamily => 'Debian'
  }}

  context 'with default values for all parameters' do
    it { should contain_class('goaudit') }
  end
end
