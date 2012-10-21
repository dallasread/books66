require "bundler/capistrano"

load "config/recipes/base"
load "config/recipes/assets"
load "config/recipes/tail"
load "config/recipes/seed"
load "config/recipes/check"
load "config/recipes/monit"
load "config/recipes/sys"
load "config/recipes/mailman"
load "config/recipes/resque"

load "config/recipes/nginx"
load "config/recipes/unicorn"
load "config/recipes/postgresql"
load "config/recipes/nodejs"
load "config/recipes/rbenv"
load "config/recipes/bundler"
load "config/recipes/redis"
load "config/recipes/imagemagick"

server "208.68.37.206", :web, :app, :db, primary: true

set :application, "books66"
set :user, "deployer"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false
set :workers, { '*' => 5 }

set :scm, "git"
set :repository, "git@github.com:dallas22ca/#{application}.git"
set :branch, "master"

set :maintenance_template_path, File.expand_path("../recipes/templates/maintenance.html.erb", __FILE__)

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:migrate"
after "deploy", "deploy:cleanup"
after "deploy:install", "deploy:autoremove"