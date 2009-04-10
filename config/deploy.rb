set :application, "rallclansneed"
set :scm, :git
set :repository,  "git@dev.innomind.info:rallclansneed.git"
set :branch, "master"
set :deploy_to, "/var/www/webapps/#{application}"

role :app, "dev.innomind.info"
role :web, "dev.innomind.info"
role :db, "dev.innomind.info", :primary => true

set :user, "pw"
set :use_sudo, false
set :deploy_via, :remote_cache