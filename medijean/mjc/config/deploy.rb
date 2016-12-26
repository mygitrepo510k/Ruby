require 'bundler/capistrano'
require "rvm/capistrano"
require 'capistrano/ext/multistage'
require "capistrano-resque"

load "config/recipes/base"
load "config/recipes/unicorn"
load 'deploy/assets'

set :user, "deploy"

set :application, "mjc"
set :repository,  "git@git.medijean.com:medijean/mjc.git"
set :deploy_to,   "/home/#{user}/apps/#{application}"
set :rvm_type, :system

# multistage
set :stages,  %w(production bvt)
set :default_stage, 'bvt'
require 'capistrano/ext/multistage'

# set :rvm_ruby_string, :local               # use the same ruby as used locally for deployment
# set :rvm_autolibs_flag, "read-only"        # more info: rvm help autolibs

# before 'deploy:setup', 'rvm:install_rvm'   # install RVM
# before 'deploy:setup', 'rvm:install_ruby'  # install Ruby and create gemset, OR:
# before 'deploy:setup', 'rvm:create_gemset' # only create gemset
after "deploy:restart", "resque:restart"

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :deploy_via, :remote_cache

set :normalize_asset_timestamps, false

`ssh-add` 

set :ssh_options, { :forward_agent => true }

set :default_run_options, {:pty => true}

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts


set :use_sudo, false
after "deploy", "deploy:migrate"
after "deploy", "deploy:seed"


# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart do; end

  desc "reload the database with seed data"
  task :seed do
    run "cd #{current_path}; bundle exec rake db:seed RAILS_ENV=#{rails_env}"
  end
end

desc "Remote console" 
task :console, :roles => :app do
  server = find_servers(:roles => [:app]).first
  run_with_tty server, %W(source /etc/profile; bundle exec rails console #{rails_env} )
end

def run_with_tty(server, cmd)
  # looks like total pizdets
  command = []
  command += %W( ssh -t #{gateway} -l #{self[:gateway_user] || self[:user]} ) if     self[:gateway]
  command += %W( ssh -t )
  command += %W( -p #{server.port}) if server.port
  command += %W( -l #{user} #{server.host} )
  command += %W( cd #{current_path} )
  # have to escape this once if running via double ssh
  command += [self[:gateway] ? '\&\&' : '&&']
  command += Array(cmd)
  system *command
end

desc "tail production log files" 
task :logs, :roles => :app do
  trap("INT") { puts 'Interupted'; exit 0; }
  run "tail -f #{shared_path}/log/production.log" do |channel, stream, data|
    puts  # for an extra line break before the host name
    puts "#{channel[:host]}: #{data}" 
    break if stream == :err
  end
end

set :default_environment, {
  'STRIPE_API_KEY' => "sk_B8e9nrYcT5broT5GbRD84iWP4PSuA",
  'STRIPE_PUBLIC_KEY' => "pk_Jv3okyasZfipvvuR9qtpsYu7TPr99"
}
