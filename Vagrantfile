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
  config.vm.define "controller" do |controller|
    controller.vm.hostname = "controller.localdomain"
    controller.vm.network "private_network", ip: "172.28.128.20"
    controller.vm.network "forwarded_port", guest: 6443, host: 6443
    #controller.vm.provision :shell, :inline => "ln -sf /vagrant/puppet/hiera.yaml /etc/puppetlabs/puppet/hiera.yaml"
    #controller.vm.provision :shell, :inline => "yum install -y redhat-lsb-core"
    #controller.vm.provision :shell, :inline => "/opt/puppetlabs/puppet/bin/gem install r10k"
    #controller.vm.provision :shell, :inline => "/opt/puppetlabs/puppet/bin/r10k puppetfile install --puppetfile=/vagrant/puppet/Puppetfile"
    controller.vm.provision :shell, :inline => "puppet apply /vagrant/puppet/manifests/site.pp"
    # Something is out of order, a pre-flight check fails, run puppet again to resolve
    controller.vm.provision :shell, :inline => "puppet apply /vagrant/puppet/manifests/site.pp"
    controller.vm.provision "shell", path: "scripts/create-admin-user.sh"
  end

  config.vm.define "worker1" do |worker1|
    worker1.vm.hostname = "worker1.localdomain"
    worker1.vm.network "private_network", ip: "172.28.128.21"
    #worker1.vm.provision :shell, :inline => "ln -sf /vagrant/puppet/hiera.yaml /etc/puppetlabs/puppet/hiera.yaml"
    #worker1.vm.provision :shell, :inline => "yum install -y redhat-lsb-core"
    #worker1.vm.provision :shell, :inline => "/opt/puppetlabs/puppet/bin/gem install r10k"
    #worker1.vm.provision :shell, :inline => "/opt/puppetlabs/puppet/bin/r10k puppetfile install --puppetfile=/vagrant/puppet/Puppetfile"
    worker1.vm.provision :shell, :inline => "puppet apply /vagrant/puppet/manifests/site.pp"
    # Something is out of order, a pre-flight check fails, run puppet again to resolve
    worker1.vm.provision :shell, :inline => "puppet apply /vagrant/puppet/manifests/site.pp"
  end

  config.vm.define "worker2" do |worker2|
    worker2.vm.hostname = "worker2.localdomain"
    worker2.vm.network "private_network", ip: "172.28.128.22"
    #worker2.vm.provision :shell, :inline => "ln -sf /vagrant/puppet/hiera.yaml /etc/puppetlabs/puppet/hiera.yaml"
    #worker2.vm.provision :shell, :inline => "yum install -y redhat-lsb-core"
    #worker2.vm.provision :shell, :inline => "/opt/puppetlabs/puppet/bin/gem install r10k"
    #worker2.vm.provision :shell, :inline => "/opt/puppetlabs/puppet/bin/r10k puppetfile install --puppetfile=/vagrant/puppet/Puppetfile"
    worker2.vm.provision :shell, :inline => "puppet apply /vagrant/puppet/manifests/site.pp"
    # Something is out of order, a pre-flight check fails, run puppet again to resolve
    worker2.vm.provision :shell, :inline => "puppet apply /vagrant/puppet/manifests/site.pp"
    worker2.vm.post_up_message = "
To access this k8s cluster:
1. Import the files/kubecfg.p12 to your computer's certificate store or web browser

2. Navigate to https://localhost:6443/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy (may need to relanch browser after step 1)

3. Copy the token located in files/service-account-token, select \"Token\" option on the Dashbord, paste the token and click SIGN IN"
  end
end
