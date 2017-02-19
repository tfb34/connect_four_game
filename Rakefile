require 'rspec/core/rake_task'



task :default do
	RSpec::Core::RakeTask.new(:spec) do |t|
		t.pattern = 'spec/lib/connectFour_spec.rb'
	end
	Rake::Task["spec"].execute
end