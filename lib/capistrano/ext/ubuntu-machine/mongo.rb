namespace :mongo do
  desc "Install Mongo"
  task :install, :roles => :db do  
    mongo_version ||= "1.6.5"
    file            = "mongodb-linux-x86_64-#{mongo_version}"

    run "wget http://fastdl.mongodb.org/linux/#{file}.tgz && tar xzf #{file}.tgz"
    run "rm #{file}.tgz"
    
    sudo "mv #{file} /opt/mongo"
    sudo "mkdir -p /data/db/"
    sudo "sudo chown `id -u` /data/db"
    sudo "touch /var/run/mongo.pid"

    put render("mongo.initd", binding), "mongo"   
    sudo "mv mongo /etc/init.d"
    sudo "chmod +x /etc/init.d/mongo"
    sudo "update-rc.d mongo defaults 98 02"
  end
  
  desc "Starts the MongoDB Server"
  task :start, :roles => :db do
    sudo "/etc/init.d/mongo start"
  end
  
  desc "Stops the MongoDB Server"
  task :stop, :roles => :db do
    sudo "/etc/init.d/mongo stop"
  end
  
  desc "Retrieves the status of the MongoDB Server"
  task :status, :roles => :db do
    sudo "/etc/init.d/mongo status"
  end
  
  desc " MongoDB Server"
  task :restart, :roles => :db do
    sudo "/etc/init.d/mongo restart"
  end
end