#require 'mongrel_cluster/recipes'

set :application, "rallclansneed"
set :scm, :git
set :repository,  "git@dev.innomind.info:rallclansneed.git"
set :branch, "online"
set :deploy_to, "/home/deploy/rallclansneed"
set :mongrel_conf, "#{current_path}/config/mongrel_cluster.yml"

role :web, "filer.innomind.info"
role :app, "85.131.209.59", "85.131.209.60", "85.131.209.61"
role :db, "85.131.209.61", :primary => true

set :user, "deploy"
set :use_sudo, false
set :deploy_via, :remote_cache

require 'erb'

before "deploy:setup", :db
after "deploy:update_code", "db:symlink" 

namespace :db do
  desc "Create database yaml in shared path" 
  task :default do
    db_config = ERB.new <<-EOF
    development: 
      adapter: postgresql
      encoding: unicode
      database: acn_development
      username: allclansneed
      password: allclansneed
      host: database.innomind.info

    test: development

    production:
      adapter: postgresql
      encoding: unicode
      database: acn_production
      username: allclansneed
      password: allclansneed
      host: database.innomind.info
    EOF

    run "mkdir -p #{shared_path}/config" 
    put db_config.result, "#{shared_path}/config/database.yml" 
  end

  desc "Make symlink for database yaml" 
  task :symlink do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml" 
  end
end

