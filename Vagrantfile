# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  
  config.vm.box = "ubuntu/trusty64"
  config.vm.box_check_update = false
  config.vm.network "forwarded_port", guest: 80, host: 38080, auto_correct: true
  config.vm.provision "shell", path: "elk.sh"
  config.vm.hostname = "elk-local"

end
