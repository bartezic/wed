namespace :git do
  desc "Install git"
  task :install, roles: :app do
    run "#{sudo} apt-get -y install curl git-core"
  end
  after "deploy:install", "git:install"
end
