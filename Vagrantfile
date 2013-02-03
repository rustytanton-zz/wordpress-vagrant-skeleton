Vagrant::Config.run do |config|
  # config.vm.box_url = "http://rtpublic.s3.amazonaws.com/vagrant/boxes/centos/5.7/x86_64/centos57-x86_64.box"
  config.vm.box_url = "http://developer.nrel.gov/downloads/vagrant-boxes/CentOS-6.3-i386-v20130101.box"
  config.vm.box = "centos63"
  config.vm.network :bridged
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "provision"
    puppet.manifest_file = "wordpress.pp"
  end
  config.vm.customize ["modifyvm", :id, "--memory", 512]
  # config.vm.host_name = "domain.com"
end
