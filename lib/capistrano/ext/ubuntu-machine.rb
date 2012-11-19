unless Capistrano::Configuration.respond_to?(:instance)
  abort "Requires Capistrano 2"
end

# Dir["#{File.dirname(__FILE__)}/ubuntu-machine/*.rb"].each { |lib| 
#   Capistrano::Configuration.instance.load {load(lib)}   
# }


SUPPORTED_DISTRIBUTIONS = ["jaunty", "hardy", "maverick"]

Capistrano::Configuration.instance.load {load("#{File.dirname(__FILE__)}/ubuntu-machine/apache.rb")}
Capistrano::Configuration.instance.load {load("#{File.dirname(__FILE__)}/ubuntu-machine/aptitude.rb")}
Capistrano::Configuration.instance.load {load("#{File.dirname(__FILE__)}/ubuntu-machine/extras.rb")}
Capistrano::Configuration.instance.load {load("#{File.dirname(__FILE__)}/ubuntu-machine/ffmpeg.rb")}
Capistrano::Configuration.instance.load {load("#{File.dirname(__FILE__)}/ubuntu-machine/gems.rb")}
Capistrano::Configuration.instance.load {load("#{File.dirname(__FILE__)}/ubuntu-machine/git.rb")}
Capistrano::Configuration.instance.load {load("#{File.dirname(__FILE__)}/ubuntu-machine/odbc.rb")}
Capistrano::Configuration.instance.load {load("#{File.dirname(__FILE__)}/ubuntu-machine/helpers.rb")}
Capistrano::Configuration.instance.load {load("#{File.dirname(__FILE__)}/ubuntu-machine/iptables.rb")}
Capistrano::Configuration.instance.load {load("#{File.dirname(__FILE__)}/ubuntu-machine/lmsensors.rb")}
Capistrano::Configuration.instance.load {load("#{File.dirname(__FILE__)}/ubuntu-machine/machine.rb")}
Capistrano::Configuration.instance.load {load("#{File.dirname(__FILE__)}/ubuntu-machine/mysql.rb")}
Capistrano::Configuration.instance.load {load("#{File.dirname(__FILE__)}/ubuntu-machine/mongo.rb")}
Capistrano::Configuration.instance.load {load("#{File.dirname(__FILE__)}/ubuntu-machine/network.rb")}
Capistrano::Configuration.instance.load {load("#{File.dirname(__FILE__)}/ubuntu-machine/ntp.rb")}
Capistrano::Configuration.instance.load {load("#{File.dirname(__FILE__)}/ubuntu-machine/php.rb")}
Capistrano::Configuration.instance.load {load("#{File.dirname(__FILE__)}/ubuntu-machine/postfix.rb")}
Capistrano::Configuration.instance.load {load("#{File.dirname(__FILE__)}/ubuntu-machine/ruby.rb")}
Capistrano::Configuration.instance.load {load("#{File.dirname(__FILE__)}/ubuntu-machine/ssh.rb")}
Capistrano::Configuration.instance.load {load("#{File.dirname(__FILE__)}/ubuntu-machine/tmpfs.rb")}
Capistrano::Configuration.instance.load {load("#{File.dirname(__FILE__)}/ubuntu-machine/utils.rb")}
Capistrano::Configuration.instance.load {load("#{File.dirname(__FILE__)}/ubuntu-machine/vsftpd.rb")}
Capistrano::Configuration.instance.load {load("#{File.dirname(__FILE__)}/ubuntu-machine/rails3.rb")}