# load "config/recipes/base"
# load "config/recipes/nginx"
# load "config/recipes/unicorn"
# load "config/recipes/postgresql"
# load "config/recipes/nodejs"
# load "config/recipes/imagemagick"
# # load "config/recipes/rbenv"
# # load "config/recipes/check"
# load "config/recipes/git"

# set :application, 'wed'
set :deploy_to, "/home/deployer/apps/wed"
set :repo_url, 'git@github.com:bartezic/wed.git'
set :branch, "master"
set :use_sudo, false

# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# set :deploy_to, '/var/www/my_app'
# set :scm, :git

set :format, :pretty
set :log_level, :debug
set :pty, true

set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
# set :keep_releases, 5

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  after :finishing, 'deploy:cleanup'

end
