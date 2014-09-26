require_relative "./evm_test_helper"

if defined?(RSpec)
namespace :test do
  task :setup_automation => :setup_db

  desc "Run all automation specs"
  RSpec::Core::RakeTask.new(:automation => :initialize) do |t|
    EvmTestHelper.init_rspec_task(t)
    t.pattern = EvmTestHelper::AUTOMATION_SPECS
  end
end
end # ifdef
