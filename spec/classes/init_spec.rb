require 'spec_helper'

describe 'goaudit' do
  let (:facts) {{
    :osfamily => 'Debian'
  }}

  describe 'with default values for all parameters' do
    it 'should install Go-Audit from a package' do
      is_expected.to contain_package('go-audit').with({
        :ensure => 'present',
      })
    end

    it 'should write config to /etc/go-audit.yaml' do
      is_expected.to contain_file('/etc/go-audit.yaml').with({
        :owner => 'root',
        :mode  => '0644',
      })
      is_expected.to contain_datacat_fragment('goaudit_config_main')
      is_expected.to contain_datacat('/etc/go-audit.yaml')
    end

    it 'should manage the go-audit service' do
      is_expected.to contain_service('go-audit').with({
        :ensure => 'running',
        :enable => true,
      })
    end

    it { is_expected.to contain_datacat_fragment('goaudit_config_main').with_data(
        lambda { |data|
          data['main']['events'] != nil and \
          data['main']['message_tracking'] != nil and \
          data['main']['output'] != nil and \
          data['main']['log'] != nil
        }
      )
    }
  end

  describe '#output_syslog_enabled' do
    context 'set to true' do
      let (:params) {{ :output_syslog_enabled => true }}
      it { is_expected.to contain_datacat_fragment('goaudit_config_main').with_data(
          lambda { |data| data['main']['output']['syslog']['enabled'] == true }
        )
      }
    end

    context 'set to false' do
      let (:params) {{ :output_syslog_enabled => false }}
      it { is_expected.to contain_datacat_fragment('goaudit_config_main').with_data(
          lambda { |data| data['main']['output']['syslog']['enabled'] == false }
        )
      }
    end

    context 'invalid value' do
      let (:params) {{ :output_syslog_enabled => 'not_a_bool' }}
      it { is_expected.to raise_error(Puppet::Error, /is not a boolean/) }
    end
  end
end

