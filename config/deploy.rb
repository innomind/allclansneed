set :application, "rallclansneed"
set :scm, :git
set :repository,  "git@dev.innomind.info:rallclansneed.git"
set :branch, "master"
set :deploy_to, "/home/ben/rallclansneed"

role :app, "85.131.209.61"
role :web, "85.131.209.61"
role :db, "85.131.209.61", :primary => true

set :user, "root"
set :use_sudo, false
set :deploy_via, :remote_cache