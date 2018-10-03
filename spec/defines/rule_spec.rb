require 'spec_helper'

describe 'goaudit::rule' do
  let (:title) { 'example' }
  let (:facts) {{
    :lsbdistid       => 'Debian',
    :osfamily        => 'Debian',
  }}
  let (:pre_condition) { 'include ::goaudit' }

  context 'with a single rule' do
    let (:params) {{
      :content => 'rspec'
    }}

    it {
      is_expected.to contain_datacat_fragment('go-audit rule example').with({
        :target => '/etc/go-audit.yaml',
        :order  => '10',
        :data   => {
          'rules' => [
            {
              'comment' => nil,
              'content' => 'rspec',
            }
          ]
        }
      })
    }
  end

  context 'with a list of rules' do
    let (:params) {{
      :content => ['rspec 1', 'rspec 2']
    }}

    it {
      is_expected.to contain_datacat_fragment('go-audit rule example').with({
        :target => '/etc/go-audit.yaml',
        :order  => '10',
        :data   => {
          'rules' => [
            {
              'comment' => nil,
              'content' => ['rspec 1', 'rspec 2'],
            }
          ]
        }
      })
    }
  end

  context 'with a comment' do
    let (:params) {{
      :content => ['rspec 1', 'rspec 2'],
      :comment => 'rspec rule comment',
    }}

    it {
      is_expected.to contain_datacat_fragment('go-audit rule example').with({
        :target => '/etc/go-audit.yaml',
        :order  => '10',
        :data   => {
          'rules' => [
            {
              'comment' => 'rspec rule comment',
              'content' => ['rspec 1', 'rspec 2'],
            }
          ]
        }
      })
    }
  end

  context 'with an invalid order' do
    let (:params) {{
      :content => 'rspec',
      :order   => 10,
    }}

    it { is_expected.to raise_error(Puppet::Error, /'order' expects a String value/) }
  end
end

