#!/bin/bash

sudo dnf clean all
sudo dnf install -y dkms
sudo systemctl enable dkms
if (uname -r | grep -q ^6\\.12\\.); then
  if ( dnf search kernel6.12-headers | grep -q kernel ); then
    sudo dnf install -y kernel6.12-headers-$(uname -r) kernel6.12-devel-$(uname -r) kernel6.12-modules-extra-$(uname -r) kernel6.12-modules-extra-common-$(uname -r) --allowerasing
  else
    sudo dnf install -y kernel-headers-$(uname -r) kernel-devel-$(uname -r) kernel6.12-modules-extra-$(uname -r) kernel-modules-extra-common-$(uname -r) --allowerasing
  fi
else
  if ( ! cat /etc/dnf/dnf.conf | grep ^exclude | grep -q 6\\.12 ); then
    sudo sed -i '$aexclude=kernel6.12* kernel-headers-6.12* kernel-devel-6.12* kernel-modules-extra-common-6.12* kernel-modules-extra-6.12*' /etc/dnf/dnf.conf
  fi
  sudo dnf install -y kernel-headers-$(uname -r) kernel-devel-$(uname -r) kernel-modules-extra-$(uname -r) kernel-modules-extra-common-$(uname -r)
fi

cd /tmp

if (arch | grep -q x86); then
  ARCH=x86_64
else
  ARCH=sbsa
fi
sudo dnf config-manager --add-repo https://developer.download.nvidia.com/compute/cuda/repos/amzn2023/$ARCH/cuda-amzn2023.repo
sudo dnf clean expire-cache

sudo dnf module enable -y nvidia-driver:open-dkms
sudo dnf install -y nvidia-open
sudo dnf install -y nvidia-xconfig

# sudo dnf install -y cuda-toolkit
# sed -i '$aexport PATH=\"\$PATH:/usr/local/cuda/bin\"' /home/ec2-user/.bashrc
# . /home/ec2-user/.bashrc

sudo dnf install -y docker
sudo systemctl enable docker
sudo usermod -aG docker ec2-user

if (! dnf search nvidia | grep -q nvidia-container-toolkit); then
  sudo dnf config-manager --add-repo https://nvidia.github.io/libnvidia-container/stable/rpm/nvidia-container-toolkit.repo
fi
sudo dnf install -y nvidia-container-toolkit
sudo nvidia-ctk runtime configure --runtime=docker
sudo systemctl restart docker
