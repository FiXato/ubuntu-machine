namespace :utils do
  
  desc "Reboot the system."
  task :reboot, :roles => :gateway do
    sure = Capistrano::CLI.ui.ask("Are you sure you want to reboot now? (y/n) : ")
    sudo "reboot" if sure=="y"
  end
  
  desc "Force a reboot of the system."
  task :force_reboot, :roles => :gateway do
    sudo "reboot"
  end
  
  desc "Show the amount of free disk space."
  task :disk_space, :roles => :gateway do
    run "df -h /"
  end

  desc "Display amount of free and used memory in the system."
  task :free, :roles => :gateway do
    run "free -m"
  end

  desc "Display passenger status information."
  task :passenger_status, :roles => :gateway do
    sudo "/opt/ruby-enterprise/bin/passenger-status"
  end

  desc "Display passenger memory usage information."
  task :passenger_memory, :roles => :gateway do
    sudo "/opt/ruby-enterprise/bin/passenger-memory-stats"
  end  

  desc "Activate Phusion Passenger Enterprise Edition."
  task :passenger_enterprise, :roles => :gateway do

    sudo_and_watch_prompt("/opt/ruby-enterprise/bin/passenger-make-enterprisey", [/Key\:/,  /again\:/])    
  end
  
  desc "Copy sources list"
  task :copy_sources, :roles => :gateway do 
    distribution = nil       
    run "cat /etc/lsb-release" do |ch, stream, data|
      distribution = data.scan(/^DISTRIB_CODENAME=(\w*)$/)[0][0]
      
      unless SUPPORTED_DISTRIBUTIONS.include?(distribution)
        puts "Your distribution is not supported by Ubuntu-Machine at this time. (#{distribution})"
        exit
      end
    end

    put render("sources.#{distribution}", binding), "sources.list"
    sudo "mv sources.list /etc/apt/sources.list"
    sudo "apt-get update"
  end
end