namespace :build do
  task :custom do
    ENV['RAILS_ENV'] = 'test'
    ENV['RCOV_PARAMS'] = "-o #{ENV['CC_BUILD_ARTIFACTS']}/coverage"
    Rake::Task['test:units:rcov'].invoke
    Rake::Task['test:functionals:rcov'].invoke
  end
end