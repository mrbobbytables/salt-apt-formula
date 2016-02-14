require 'bundler/setup'
require 'kitchen'

task :default => 'integration:docker'

Kitchen.logger = Kitchen.default_file_logger

desc 'Execute integration tests via test-kitchen'
namespace :integration do
  desc 'Run integration test with docker'
  task :docker, [:instance] do |t, args|
    args.with_defaults(instance: 'apt-ubuntu-trusty')
    @loader = Kitchen::Loader::YAML.new(local_config: '.kitchen.yml')
    instances = Kitchen::Config.new(loader: @loader).instances
    instances.get(args.instance).verify
  end
end
