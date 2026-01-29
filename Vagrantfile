
Vagrant.configure("2") do |config|
   config.vm.box = "ubuntu/jammy64"
   config.vm.synced_folder "src/", "/app"
   config.vm.boot_timeout = 600
   config.vm.provider "virtualbox" do |vb|
         vb.gui = false
   end
   config.vm.provision "shell", inline: <<-SHELL
      apt-get update
      chmod +x /app/scripts/install_docker.sh
      bash /app/scripts/install_docker.sh
    SHELL

   config.vm.define "manager01" do |manager01|
      manager01.vm.hostname="manager01"
      manager01.vm.network "private_network", ip: "192.168.50.10"
      manager01.vm.provision "shell", inline: <<-SHELL
         docker swarm init --advertise-addr "192.168.50.10"
         docker swarm join-token worker > /vagrant/swarm_worker.txt
      SHELL
   end
   config.vm.define "worker01" do |worker01|
      worker01.vm.hostname="worker01"
      worker01.vm.network "private_network", ip: "192.168.50.11"
      worker01.vm.provision "shell", inline: <<-SHELL
         bash /vagrant/swarm_worker.txt
      SHELL
   end
   config.vm.define "worker02" do |worker02|
      worker02.vm.hostname="worker02"
      worker02.vm.network "private_network", ip: "192.168.50.12"
      worker02.vm.provision "shell", inline: <<-SHELL
         bash /vagrant/swarm_worker.txt
      SHELL
   end       

end
