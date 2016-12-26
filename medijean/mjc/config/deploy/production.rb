logger.info "Deploying to Production"
#set :domain, "localhost"
set :branch, "production"
set :rails_env, "production"
# set :copy_dir, "/home/ashish/tmp"
# set :remote_copy_dir, "/tmp"

role :web, "67.205.104.66"
role :app, "67.205.104.64"
role :db,  "67.205.104.64", :primary => true

role :resque_worker, "67.205.104.66"
role :resque_scheduler, "67.205.104.66"