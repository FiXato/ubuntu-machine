namespace :ssh do
  _cset :ssh_secundary_keys, []
  desc <<-DESC
    Setup SSH on the gateway host. Runs `upload_keys`, `install_ovh_ssh_key` AND \
    `configure_sshd` then reloads the SSH service to finalize the changes.
  DESC
  task :setup, :roles => :gateway do
    upload_keys
    configure_sshd
    install_ovh_ssh_key if ["ovh-rps", "ovh-dedie"].include?(hosting_provider)
    reload
  end

  desc "Uploads secundary ssh pubkeys defined in ssh_secundary_keys which don't necessarily belong to you."
  task :add_secundary_keys, :roles => :gateway do
    run "mkdir -p ~/.ssh"
    run "chown -R #{user}:#{user} ~/.ssh"
    run "chmod 700 ~/.ssh"

    [*ssh_secundary_keys].each do |key|
      key = File.read("#{key}.pub")
      run "echo '#{key}' >> ./.ssh/authorized_keys2"
    end
  end
  
  desc <<-DESC
    Uploads your local public SSH keys to the server. A .ssh folder is created if \
    one does not already exist. The SSH keys default to the ones set in \
    Capistrano's ssh_options. You can change this by setting ssh_options[:keys] = \
    ["/home/user/.ssh/id_dsa"].

    See "SSH copy" and "SSH Permissions" sections on \
    http://articles.slicehost.com/2008/4/25/ubuntu-hardy-setup-page-1
  DESC
  task :upload_keys, :roles => :gateway do
    run "mkdir -p ~/.ssh"
    run "chown -R #{user}:#{user} ~/.ssh"
    run "chmod 700 ~/.ssh"

    authorized_keys = ssh_options[:keys].collect { |key| File.read("#{key}.pub") }.join("\n")
    put authorized_keys, "./.ssh/authorized_keys2", :mode => 0600
  end

  desc <<-DESC
    Configure SSH daemon with more secure settings recommended by Slicehost. The \
    will be configured to run on the port configured in Capistrano's "ssh_options". \
    This defaults to the standard SSH port 22. You can change this by setting \
    ssh_options[:port] = 3000. Note that this change will not take affect until \
    reload the SSH service with `cap ssh:reload`.

    See "SSH config" section on \
    http://articles.slicehost.com/2008/4/25/ubuntu-hardy-setup-page-1
  DESC
  task :configure_sshd, :roles => :gateway do
    put render("sshd_config", binding), "sshd_config"
    sudo "mv sshd_config /etc/ssh/sshd_config"
  end
  
  desc <<-DESC
    Install OVH SSH Keys
  DESC
  task :install_ovh_ssh_key, :roles => :gateway do
    sudo "wget ftp://ftp.ovh.net/made-in-ovh/cle-ssh-public/installer_la_cle.sh -O installer_la_cle.sh"
    sudo "sh installer_la_cle.sh"
  end
  
  desc <<-DESC
    Reload SSH service.
  DESC
  task :reload, :roles => :gateway do
    sudo "/etc/init.d/ssh reload"
  end
  
  desc <<-DESC
    Upload a default SSH config.
  DESC
  task :upload_ssh_config, :roles => :gateway do
    _cset(:ssh_config) { abort "Please specify the location of the ssh config file you want to upload:\n  set :ssh_config, '~/.ssh/config'" }
    run "mkdir -p ~/.ssh"
    run "chown -R #{user}:#{user} ~/.ssh"
    run "chmod 700 ~/.ssh"
    put File.read(File.expand_path(ssh_config)), "./.ssh/config", :mode => 0600
  end
  
end