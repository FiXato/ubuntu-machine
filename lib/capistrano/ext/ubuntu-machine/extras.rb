namespace :extras do
  desc "Installs extra utils: curl, lynx, mailutils, munin, imagemagick"
  task :install_all do
    install_curl
    install_lynx
    install_mailutils
    install_munin
    install_imagemagick
  end

  desc "Installs extra util curl"
  task :install_curl do
    sudo "aptitude install -y curl"
  end

  desc "Installs extra util lynx"
  task :install_lynx do
    sudo "aptitude install -y lynx"
  end

  desc "Installs extra util mailutils"
  task :install_mailutils do
    sudo "aptitude install -y mailutils"
  end

  desc "Installs extra util munin"
  task :install_munin do
    sudo "aptitude install -y munin"
  end

  desc "Installs extra util imagemagick"
  task :install_imagemagick do
    sudo "apt-get install libmagick9-dev librmagick-ruby1.8 librmagick-ruby libmagickcore-dev msttcorefonts imagemagick libmagickwand-dev"
    sudo "ldconfig"
    sudo "gem install rmagick"
  end
end

#