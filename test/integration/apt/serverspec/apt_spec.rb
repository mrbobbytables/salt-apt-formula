require 'serverspec'
require 'yaml'

set :backend, :exec

if File.exists? ('/tmp/kitchen/srv/pillar/apt.sls')
  apt_vars = YAML.load_file('/tmp/kitchen/srv/pillar/apt.sls')
  if ! apt_vars.nil?

    # test if unattended-upgrades package is installed
    if ! apt_vars['apt']['lookup']['unattended_upgrades'].nil?
      describe package('unattended-upgrades') do
        it { should be_installed }
      end
    end

    # test if ppa support is enabled
    if ! apt_vars['apt']['lookup']['ppa'].nil?
      describe command('dpkg --list | grep -q "\python-software-properties\|software-properties-common"') do
        its(:exit_status) { should eq 0 }
      end
    end

    # test for transports
    if ! apt_vars['apt']['lookup']['transports'].nil?
      describe command('dpkg --list') do
        apt_vars['apt']['lookup']['transports'].each do |transport|
          case transport
          when 'https'
            its(:stdout) { should contain 'apt-transport-https' }
          when 'debtransport'
            its(:stdout) { should contain 'apt-transport-debtorrent' }
          when 's3'
            its(:stdout) { should contain 'apt-transport-s3' }
          when 'spacewalk'
            its(:stdout) { should contain 'apt-transport-spacewalk' }
          end
        end
      end
    end

    # test configs, verify param values between param name and apt block end
    if ! apt_vars['apt']['lookup']['config'].nil?
      apt_vars['apt']['lookup']['config'].each do | k,v |
        describe file("/etc/apt/apt.conf.d/#{k}") do
          it { should be_file }
          v['params'].each do | param |
            it { should contain param['name'] }
            param['value'].each do | value |
              it { should contain(value).from(param['name']).to('/};$/') }
            end
          end
        end
      end
    end

  end
end
