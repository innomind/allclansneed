set :application, "rallclansneed"
set :scm, :git
set :repository,  "git@dev.innomind.info:rallclansneed.git"
set :branch, "master"
set :deploy_to, "/home/deploy/rallclansneed"
set :mongrel_conf, "#{current_path}/config/mongrel_cluster.yml"

role :web, "filer.innomind.info"
role :app, "85.131.209.59", "85.131.209.60", "85.131.209.61"
role :db, "85.131.209.61", :primary => true

set :user, "deploy"
set :use_sudo, false
set :deploy_via, :remote_cache