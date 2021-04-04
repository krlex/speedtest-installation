#!/usr/bin/env bash

export DEBIAN="gnupg1 apt-transport-https dirmngr"
export UBUNTU="gnupg1 apt-transport-https dirmngr"
export FEDORA="wget"
export DOWNLOAD="wget https://bintray.com/ookla/rhel/rpm -O /etc/yum.repos.d/bintray-ookla-rhel.repo"

  install_debian() {
    $SUDO apt update
    $SUDO apt install -y $DEBIAN
    export INSTALL_KEY=379CE192D401AB61
    $SUDO apt-key adv --keyserver keyserver.ubuntu.com --recv-keys $INSTALL_KEY
    echo "deb https://ookla.bintray.com/debian generic main" | $SUDO tee  /etc/apt/sources.list.d/speedtest.list
    $SUDO apt update
    echo " Speedtest is ready for Debian"
    $SUDO apt install -y speedtest
    echo " Finished Speedtest installation"
  
  }

  install_ubuntu() {
    $SUDO apt update
    $SUDO apt install -y $UBUNTU 
    export INSTALL_KEY=379CE192D401AB61
    $SUDO apt-key adv --keyserver keyserver.ubuntu.com --recv-keys $INSTALL_KEY
    echo "deb https://ookla.bintray.com/debian generic main" | $SUDO tee  /etc/apt/sources.list.d/speedtest.list
    $SUDO apt update
    echo " Speedtest is ready for Ubuntu"
    $SUDO apt install -y speedtest
    echo " Finished Speedtest installation"
  
  }
  
  install_fedora() {
    $SUDO dnf update -y
    $SUDO dnf -y install $FEDORA 
    $SUDO $DOWNLOAD
  
    echo " Packages is ready for Fedora"
    $SUDO yum install -y speedtest
    echo " Finished Packages installation"
  
  }

  install_centos() {
    $SUDO dnf update -y
    $SUDO dnf -y install $FEDORA 
    $SUDO $DOWNLOAD
  
    echo " Packages is ready for Fedora"
    $SUDO yum install -y speedtest
    echo " Finished Packages installation"
  
  }
  
  usage() {
    echo
    echo "Linux distribution not detected"
    echo "Use: ID=[debian|ubuntu|fedora|centos]"
    echo "Other distribution not yet supported"
    echo
  
  }
  
  if [ -f /etc/os-release ]; then
    . /etc/os-release
  elif [ -f /etc/debian_version ]; then
    $ID=debian
  fi
  
  if [[ $EUID -ne 0 ]]; then
    SUDO='sudo -H'
  else
    SUDO=''
  fi
  
  case $ID in
          'debian')
                  install_debian
          ;;
          'ubuntu')
                  install_ubuntu
          ;;
          'fedora')
                  install_fedora
          ;;
          'centos')
                  install_centos
          ;;
          *)
            usage
          ;;
esac

