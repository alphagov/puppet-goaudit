require 'spec_helper'

describe 'goaudit::filter' do
  let (:title) { 'example' }
  let (:facts) {{
    :lsbdistid       => 'Debian',
    :osfamily        => 'Debian',
  }}
  let (:pre_condition) { 'include ::goaudit' }

  describe 'complete example' do
    let (:params) {{
      :order        => '9',
      :comment      => 'rspec comment',
      :syscall      => 1234,
      :message_type => 4321,
      :regex        => 'rspec regex',
    }}

    it {
      is_expected.to contain_datacat_fragment('go-audit filter example').with({
        :target => '/etc/go-audit.yaml',
        :order  => '9',
        :data   => {
          'filters' => [
            {
              'comment'      => 'rspec comment',
              'syscall'      => 1234,
              'message_type' => 4321,
              'regex'        => 'rspec regex',
            }
          ]
        }
      })
    }
  end

  describe '#order' do
    context 'invalid value' do
      let (:params) {{
        :order        => 'banana',
        :syscall      => '1234',
        :message_type => '4321',
        :regex        => 'regex',
      }}

      it { is_expected.to raise_error(Puppet::Error, /expects an Integer/) }
    end
  end

  describe '#syscall' do
    context 'not specified' do
      let (:params) {{
        :message_type => 1234,
        :regex        => 'regex',
      }}

      it { is_expected.to raise_error(Puppet::Error, /expects a value for parameter 'syscall'/) }
    end

    context 'invalid value' do
      let (:params) {{
        :syscall      => 'invalid',
        :message_type => 1234,
        :regex        => 'regex',
      }}

      it { is_expected.to raise_error(Puppet::Error, /expects an Integer/) }
    end
  end

  describe '#message_type' do
    context 'not specified' do
      let (:params) {{
        :syscall      => 1234,
        :regex        => 'regex',
      }}

      it { is_expected.to raise_error(Puppet::Error, /expects a value for parameter 'message_type'/) }
    end
    
    context 'invalid value' do
      let (:params) {{
        :syscall      => 1234,
        :message_type => 'banana',
        :regex        => 'regex',
      }}

      it { is_expected.to raise_error(Puppet::Error, /expects an Integer/) }
    end
  end

  describe '#regex' do
    context 'not specified' do
      let (:params) {{
        :syscall      => 1234,
        :message_type => 1234,
      }}

      it { is_expected.to raise_error(Puppet::Error, /expects a value for parameter 'regex'/) }
    end
  end

end

