namespace :resque do
  task :kill_all, :except => { :no_release => true } do
    run "cd #{current_path} && rake RAILS_ENV=#{rails_env} resque:kill_all"
  end
end