logger.info "Deploying to BVT"
set :domain, "bvt1.medijean.com"
set :branch, "development"
set :rails_env, "bvt"

role :web, domain
role :app, domain
role :db,  domain, :primary => true

role :resque_worker, domain
role :resque_scheduler, domain