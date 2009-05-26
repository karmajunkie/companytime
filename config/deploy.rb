set :application, "time_system"
set :repository,  "ssh://git@git.talho.org/home/git/repositories/#{application}/.git"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
 set :deploy_to, "/var/www/admin/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion

role :app, "192.168.30.115"
role :web, "192.168.30.115"
role :db,  "192.168.30.115", :primary => true
set :scm, :git
set :branch, 'master'
set :use_sudo, false
set :user, 'root'
set :git_enable_submodules, true
set :ssh_options, {:forward_agent => true}
 
desc "mod_rails restart"
  namespace :deploy do
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
end
 
after 'deploy:update_code', 'deploy:symlink_configs'
after "deploy", "deploy:cleanup"
namespace :deploy do
  desc "we need a database. this helps with that."
  task :symlink_configs do
    run "mv #{release_path}/config/database.yml.example #{release_path}/config/database.yml"
  end
end
