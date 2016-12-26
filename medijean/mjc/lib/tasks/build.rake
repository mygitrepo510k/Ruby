task :build do
  Rake::Task["spec"].invoke
  Rake::Task["quality"].invoke
end