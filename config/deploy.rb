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
set :branch, ENV['BRANCH'] || 'develop'
set :pty,             true
set :use_sudo,        false
set :deploy_via,      :remote_cache
set :rvm_ruby_version, '2.3.8'
set :passenger_restart_with_sudo, true
set :deploy_to,       "/home/#{fetch(:user)}/apps/#{fetch(:application)}"
set :format,        :pretty
set :log_level,     :debug
set :keep_releases, 5

set :linked_dirs,  %w{log tmp/pids tmp/cache}
set :linked_files, %w{config/master.key}
namespace :deploy do

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
end


