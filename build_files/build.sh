#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/43/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
dnf5 install -y btop fastfetch

# remove unwanted kde games
dnf5 remove -y kmahjongg kmines
# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

systemctl enable podman.socket

### Modifying os-release
sed -i 's/^NAME=.*/NAME="Project GDL"/' /usr/lib/os-release
sed -i 's/^ID=.*/ID=gdl/' /usr/lib/os-release
sed -i 's/^ID_LIKE=.*/ID_LIKE="fedora"/' /usr/lib/os-release
sed -i 's/^PRETTY_NAME=.*/PRETTY_NAME="Project GDL"/' /usr/lib/os-release
sed -i 's|^HOME_URL=.*|HOME_URL="https://github.com/ProjectGDL"|' /usr/lib/os-release
sed -i 's|^BUG_REPORT_URL=.*|BUG_REPORT_URL="https://github.com/ProjectGDL/issues"|' /usr/lib/os-release

rm /usr/share/applications/htop.desktop
rm /usr/share/applications/nvtop.desktop
