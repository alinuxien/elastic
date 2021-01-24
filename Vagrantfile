Vagrant.configure("2") do |config|
  config.vm.define "elastic" do |elastic|
    elastic.vm.box = "hashicorp/bionic64"
    elastic.vm.box_version = "1.0.282"
    elastic.vm.hostname = "terraform"
    elastic.vm.network "forwarded_port", guest: 22, host: 2222
    elastic.vm.network "forwarded_port", guest: 5601, host: 5601
# LA LIGNE CI-DESSOUS DOIT ETRE SUPPRIMEE
    elastic.vm.synced_folder "../MlleC", "/home/vagrant/MlleC", type: "virtualbox"
# LA LIGNE CI-DESSUS DOIT ETRE SUPPRIMEE
    elastic.vm.provider "virtualbox" do |v|
      v.name = "elastic"
      v.memory = 16384 
      v.cpus = 12
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
      v.customize [ "guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold", 10000 ]
    end
    elastic.vm.provision :shell, path: "bootstrap.sh"
    elastic.vm.provision :shell, path: "auto_cd.sh"
    elastic.vm.provision "shell", run: "always", inline: <<-SHELL
      /bin/systemctl restart elasticsearch.service
      /bin/systemctl restart kibana.service
      /bin/systemctl restart filebeat
    SHELL
  end
end

