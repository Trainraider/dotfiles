#!/bin/bash
#untested

sudo apt update
sudo apt upgrade

#install everything in pkglist.txt
cat pkglist.txt | xargs sudo apt -y install

#install pip2
curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py
sudo python2 get-pip.py

#fetch wallpaper
mkdir ~/Pictures/backgrounds
cd ~/Pictures/backgrounds
wget https://raw.githubusercontent.com/mut-ex/wallpapers/master/vividnightlandscape.jpg

#xwallpaper, apt version crashes under recent glibc
cd /tmp
git clone --single-branch --depth=1 https://github.com/stoeckmann/xwallpaper.git
cd xwallpaper
./autogen.sh
./configure
make
sudo make install

#install up-to-date meson, don't use apt for this
sudo pip3 install meson

#For python extensions and LSPs
sudo pip3 install jedi

#i3 gaps
cd /tmp
git clone --single-branch --depth=1 https://github.com/Airblader/i3
cd i3
meson setup build --buildtype=release
meson compile -C build
sudo meson install -C build

#Picom rounded/dual kawase blur
cd /tmp
git clone --single-branch --depth=1 https://github.com/ibhagwan/picom
cd picom
meson setup build --buildtype=release
meson compile -C build
sudo meson install -C build

#Up-to-date neovim
cd /tmp
git clone --single-branch --depth=1 https://github.com/neovim/neovim
cd neovim
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install

#pfetch
cd /tmp
git clone --single-branch --depth=1 https://github.com/dylanaraps/pfetch
cd pfetch
sudo make install

#cbonsai
cd /tmp
git clone --single-branch --depth=1 https://gitlab.com/jallbrit/cbonsai
cd cbonsai
sudo make install

#Gitui
#this rust stuff is a real pain to install system-wide
curl https://sh.rustup.rs -sSf | sudo sh -s -- -y
sudo /root/.cargo/bin/cargo install gitui --root /usr

#lsd
sudo /root/.cargo/bin/cargo install lsd --root /usr

#install vim plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

#Up to date nodejs for Coc
sudo snap install node --classic --channel=edge

#nvim extensions
nvim --headless +'PlugInstall --sync' +qa
export extensions='coc-clangd coc-zig coc-git coc-json coc-python'
nvim --headless +"CocInstall -sync $extensions|qa"

#DockbarX
sudo add-apt-repository ppa:xuzhen666/dockbarx -y
sudo apt update
sudo apt install -y dockbarx xfce4-dockbarx-plugin dockbarx-themes-extra

#Fredoka One font
mkdir -p /tmp/fredoka
cd /tmp/fredoka
wget -O 'Fredoka_One.zip' 'https://fonts.google.com/download?family=Fredoka%20One'
unzip Fredoka_One.zip
rm Fredoka_One.zip
sudo mkdir -p /usr/share/fonts/fredoka_one
sudo mv * /usr/share/fonts/fredoka_one

#Hack Nerd Font
mkdir -p /tmp/hack
cd /tmp/hack
wget -O 'Hack.zip' 'https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.zip'
unzip Hack.zip
rm Hack.zip
sudo mkdir -p /usr/share/fonts/hack_nerd_font
sudo mv * /usr/share/fonts/hack_nerd_font

#update font cache
sudo fc-cache -fv

#Candy icon theme
cd /tmp
mkdir candy_icons
cd candy_icons
wget -O candy.zip https://github.com/EliverLara/candy-icons/archive/refs/heads/master.zip
unzip candy.zip
rm candy.zip
sudo mv candy-icons-master /usr/share/icons/candy-icons
sudo update-icon-caches /usr/share/icons/candy-icons/

#Sweet theme
cd /tmp
mkdir sweet
cd sweet
wget https://github.com/EliverLara/Sweet/releases/latest/download/Sweet-Dark.tar.xz
tar xf Sweet-Dark.tar.xz
rm Sweet-Dark.tar.xz


#Oh my fish
curl -L https://get.oh-my.fish | fish

#starship prompt
sh -c "$(curl -fsSL https://starship.rs/install.sh)"

cd ~
