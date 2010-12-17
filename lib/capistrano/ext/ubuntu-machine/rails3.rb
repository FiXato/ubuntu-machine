namespace :rails3 do
  desc "Install Rails3"
  task :install, :roles => :app do
     sudo "/opt/ruby-enterprise/bin/gem install rails --no-ri --no-rdoc"
     sudo "apt-get install libxml2-dev libxslt1-dev"
    end
end
