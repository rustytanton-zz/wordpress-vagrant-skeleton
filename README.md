WordPress Vagrant VM Skeleton Project
-------------------------------------

To use as a template to get a CentOS VM running a [WordPress](http://wordpress.org) dev environment.

Instructions:

1. Install [VirtualBox](https://www.virtualbox.org/) and [Vagrant](http://www.vagrantup.com/)
2. Run the command `vagrant up` from the project root
3. SSH into the VM (`ssh vagrant@127.0.0.1 -p 2222` on Windows, `vagrant ssh` on Mac/Unix). The password is "vagrant".
4. Run the `ifconfig` command to find the VM's IP address
5. Enter the IP address in a browser and you should see the WordPress install page.

The "src" directory in the repo is symbolically linked to the wp-content folder in the WordPress install in the VM.

You'll probably want to [edit your host file](http://www.howtogeek.com/howto/27350/beginner-geek-how-to-edit-your-hosts-file/) to have the VM mock a domain.

phpMyadmin is available at the path /phpmyadmin, the MySQL user name is wordpress/wordpress