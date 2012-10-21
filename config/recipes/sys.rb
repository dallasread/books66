namespace :sys do
  desc "Reboot"
  task :reboot do
    run "#{sudo} reboot -h now"
  end
end
