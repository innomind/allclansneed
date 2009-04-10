set :application, "rallclansneed"
set :scm, :git
set :repository,  "git@dev.innomind.info:rallclansneed.git"
set :branch, "master"
set :deploy_to, "/var/www/webapps/#{application}"

role :app, "dev.innomind.info"
role :web, "dev.innomind.info"
role :db, "dev.innomind.info", :primary => true

set :user, "www-data"
set :use_sudo, false
set :deploy_via, :remote_cache

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
# set :deploy_to, "/var/www/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion
