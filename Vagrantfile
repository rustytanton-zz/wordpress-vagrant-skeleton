Vagrant::Config.run do |config|
  config.vm.box = "centos63"
  config.vm.box_url = "http://rtpublic.s3.amazonaws.com/vagrant/boxes/centos/6.3/i386/centos63-i386.box"
  config.vm.network :bridged, :mac => "0800279DCF58"
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "provision"
    puppet.manifest_file = "wordpress.pp"
  end
  config.vm.customize ["modifyvm", :id, "--memory", 512]
  # config.vm.host_name = "domain.com"
end
