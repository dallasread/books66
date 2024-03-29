set_default(:unicorn_user) { user }
set_default(:unicorn_pid) { "#{current_path}/tmp/pids/unicorn.pid" }
set_default(:unicorn_config) { "#{shared_path}/config/unicorn.rb" }
set_default(:unicorn_log) { "#{shared_path}/log/unicorn.log" }
set_default(:unicorn_workers, 2)

namespace :unicorn do
  desc "Setup Unicorn initializer and app configuration"
  task :setup, roles: :app do
    run "mkdir -p #{shared_path}/config"
    template "unicorn.rb.erb", unicorn_config
    template "unicorn_init.erb", "/tmp/unicorn_init"
    run "chmod +x /tmp/unicorn_init"
    run "#{sudo} mv /tmp/unicorn_init /etc/init.d/unicorn_#{application}"
    run "#{sudo} update-rc.d -f unicorn_#{application} defaults"
  end
  after "deploy:setup", "unicorn:setup"

  desc "Start unicorn"
  task :start, roles: :app do
    run "service unicorn_#{application} start"
  end
  
  desc "Stop unicorn"
  task :stop, roles: :app do
    run "service unicorn_#{application} stop"
  end
  
  desc "Restart unicorn"
  task :restart, :roles => [:app] do
    unicorn.stop
    unicorn.start
  end
  
  after "deploy", "unicorn:restart"
end
