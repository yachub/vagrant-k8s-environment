# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure("2") do |config|
  config.vm.provision :shell, :inline => "ln -sf /vagrant/puppet/hiera.yaml /etc/puppetlabs/puppet/hiera.yaml"
  config.vm.provision :shell, :inline => "yum install -y redhat-lsb-core"
  config.vm.provision :shell, :inline => "/opt/puppetlabs/puppet/bin/gem install r10k"
  config.vm.provision :shell, :inline => "/opt/puppetlabs/puppet/bin/r10k puppetfile install --puppetfile=/vagrant/puppet/Puppetfile"

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "genebean/centos-7-puppet5"
  config.vm.define "controller01" do |controller01|
    controller01.vm.hostname = "controller01.localdomain"
    controller01.vm.network "private_network", ip: "172.28.128.19"
    controller01.vm.network "forwarded_port", guest: 6443, host: 6443
    # Allow puppet to run in background because we must wait until etcd starts on controller02
    controller01.vm.provision :shell, :inline => "puppet apply /vagrant/puppet/manifests/site.pp > /dev/null 2>&1 &"
    # Something is out of order, a pre-flight check fails, run puppet again to resolve
    #controller01.vm.provision :shell, :inline => "puppet apply /vagrant/puppet/manifests/site.pp"
    #controller01.vm.provision "shell", path: "scripts/create-admin-user.sh"
  end

  config.vm.define "controller02" do |controller02|
    controller02.vm.hostname = "controller02.localdomain"
    controller02.vm.network "private_network", ip: "172.28.128.20"
    controller02.vm.network "forwarded_port", guest: 6443, host: 7443
    controller02.vm.provision :shell, :inline => "puppet apply /vagrant/puppet/manifests/site.pp"
    controller02.vm.provision "shell", inline: "yum -y install sshpass"
    # SSH back to controller01 because etcd will not initilize until both nodes are started
    controller02.vm.provision "shell", inline: "sshpass -p 'vagrant' ssh -o StrictHostKeyChecking=no 172.28.128.20 'puppet apply /vagrant/puppet/manifests/site.pp'"
    # Something is out of order, a pre-flight check fails, run puppet again to resolve
    controller02.vm.provision :shell, :inline => "puppet apply /vagrant/puppet/manifests/site.pp"
    controller02.vm.provision "shell", path: "scripts/create-admin-user.sh"
  end

  config.vm.define "worker01" do |worker01|
    worker01.vm.hostname = "worker01.localdomain"
    worker01.vm.network "private_network", ip: "172.28.128.21"
    worker01.vm.provision :shell, :inline => "puppet apply /vagrant/puppet/manifests/site.pp"
    # Something is out of order, a pre-flight check fails, run puppet again to resolve
    worker01.vm.provision :shell, :inline => "puppet apply /vagrant/puppet/manifests/site.pp"
  end

  config.vm.define "worker02" do |worker02|
    worker02.vm.hostname = "worker02.localdomain"
    worker02.vm.network "private_network", ip: "172.28.128.22"
    worker02.vm.provision :shell, :inline => "puppet apply /vagrant/puppet/manifests/site.pp"
    # Something is out of order, a pre-flight check fails, run puppet again to resolve
    worker02.vm.provision :shell, :inline => "puppet apply /vagrant/puppet/manifests/site.pp"
    worker02.vm.post_up_message = "
To access this k8s cluster:
1. Import the files/kubecfg.p12 to your computer's certificate store or web browser

2. Navigate to https://localhost:6443/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy (may need to relanch browser after step 1)

3. Copy the token located in files/service-account-token, select \"Token\" option on the Dashbord, paste the token and click SIGN IN"
  end
end
