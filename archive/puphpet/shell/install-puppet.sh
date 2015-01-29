#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

VAGRANT_CORE_FOLDER=$(cat '/.puphpet-stuff/vagrant-core-folder.txt')

OS=$(/bin/bash "${VAGRANT_CORE_FOLDER}/shell/os-detect.sh" ID)
RELEASE=$(/bin/bash "${VAGRANT_CORE_FOLDER}/shell/os-detect.sh" RELEASE)
CODENAME=$(/bin/bash "${VAGRANT_CORE_FOLDER}/shell/os-detect.sh" CODENAME)

if [[ -f /.puphpet-stuff/install-puppet-3.7.1 ]]; then
        exit 0
    fi

#rm -rf /usr/bin/puppet

#source "/usr/local/rvm/scripts/rvm"

if [ "${OS}" == 'debian' ] || [ "${OS}" == 'ubuntu' ]; then
        apt-get -y install augeas-tools libaugeas-dev
    elif [[ "${OS}" == 'centos' ]]; then
            yum -y install augeas-devel
        fi

#        echo 'Installing Puppet requirements'
#gem install haml hiera facter json ruby-augeas --no-ri --no-rdoc
#echo 'Finished installing Puppet requirements'

echo 'Installing Puppet 3.7.1 via yum'
#gem install puppet --version 3.7.1 --no-ri --no-rdoc
yum -y install https://yum.puppetlabs.com/el/6/products/x86_64/puppetlabs-release-6-7.noarch.rpm
yum -y install puppet-3.7.1
echo 'Finished installing Puppet 3.7.1'

#cat >/usr/bin/puppet << 'EOL'
#!/bin/bash

#rvm ruby-1.9.3-p551 do puppet "$@"
#EOL

#chmod +x /usr/bin/puppet

touch /.puphpet-stuff/install-puppet-3.7.1
