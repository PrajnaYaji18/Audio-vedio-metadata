# config valid for current version and patch releases of Capistrano
lock "~> 3.12.0"
server '18.222.106.89', port: 22, roles: [:web, :app, :db], primary: true

set :application, "AddMedia"
set :repo_url, "https://github.com/PrajnaYaji18/Audio-vedio-metadata"
set :user,            'ubuntu'
set :ssh_options, {
  user: fetch(:user),
  forward_agent: true,
  auth_methods: %w[publickey],
  keys: %w[/home/amagi/Downloads/prajna.pem]
}

set :pty,             true
set :use_sudo,        false
set :deploy_via,      :remote_cache
set :rvm_ruby_version, '2.3.8'
set :passenger_restart_with_sudo, true

set :format,        :pretty
set :log_level,     :debug
set :keep_releases, 5

set :linked_dirs,  %w{log tmp/pids tmp/cache}

namespace :deploy do
  desc 'Symlinks config files for Nginx.'
  task :nginx_symlink do
    on roles(:app) do
      execute "rm -f /etc/nginx/sites-enabled/default"

      execute "sudo ln -nfs #{current_path}/config/nginx.rb /etc/nginx/sites-enabled/#{fetch(:domain)}"
      execute "sudo ln -nfs   /config/nginx.rb /etc/nginx/sites-available/#{fetch(:domain)}"
   end
  end

  desc 'Symlinks Secret.yml to the release path'
  task :secret_symlink do
    on roles(:app) do
      execute "sudo ln -nfs #{shared_path}/secrets.yml #{release_path}/config/secrets.yml"
   end
  end

  after  :updating,     :secret_symlink
  after  :updating,     :nginx_symlink
  after  :finishing,    :compile_assets
  after  :finishing,    :cleanup
  after  :finishing,    :restart
end

namespace :logs do
  desc 'Tail application logs'
  task :tail_app do
    on roles(:app) do
      execute "tail -f #{shared_path}/log/#{fetch(:stage)}.log"
    end
  end
