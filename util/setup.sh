#!/bin/bash
sudo apt update
sudo apt -y install rxvt-unicode-256color
sudo apt -y install python3-dev python3-pip
sudo apt -y install clang cmake libclang-dev llvm-dev rapidjson-dev
sudo apt -y install xcb \
                      libxcb-util0-dev \
                      libxcb-ewmh-dev \
                      libxcb-randr0-dev \
                      libxcb-icccm4-dev \
                      libxcb-keysyms1-dev \
                      libxcb-xinerama0-dev \
                      libxcb-shape0-dev \
                      libxcb-composite0-dev \
                      libxcb-cursor-dev \
                      libcurl4-openssl-dev \
                      libasound2-dev \
                      gcc \
                      make \
                      libxcb-xtest0-dev \
                      libxft-dev \
                      libx11-xcb-dev
sudo apt -y install \
  cmake-data libcairo2-dev libxcb1-dev libxcb-ewmh-dev \
  libxcb-icccm4-dev libxcb-image0-dev libxcb-randr0-dev \
  libxcb-util0-dev libxcb-xkb-dev pkg-config python3-xcbgen \
  xcb-proto libxcb-xrm-dev i3-wm libasound2-dev libmpdclient-dev \
  libiw-dev libcurl4-openssl-dev libpulse-dev \
  libxcb-composite0-dev xcb libxcb-ewmh2 libjsoncpp-dev
sudo apt -y install feh compton libcairo2-dev
sudo apt -y install ubuntu-wallpapers-cosmic ubuntu-wallpapers-bionic ubuntu-wallpapers-xenial
sudo apt -y install cmus rofi
sudo apt -y install htop powertop xdotool
pip3 install yapf jedi
mkdir ~/.vim/tmp
cd ~/.vim/pack/default/start/command-t
rake make
cd ~/builds/bspwm && make -j12 && sudo make install
cd ~/builds/sxhkd && make -j12 && sudo make install
cd ~/builds/jump && make -j12 && sudo install jump /usr/local/bin/jump
cd ~/builds/vim && ./configure --enable-rubyinterp --enable-python3interp && make -j12 && sudo make install
cd ~/builds/polybar && mkdir build && cd build
git submodule update --init --recursive
cmake .. -DCMAKE_BUILD_TYPE=Release
sudo make install
cd ~/builds/ccls && mkdir build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
sudo make install
sudo cp ~/builds/bspwm/contrib/freedesktop/bspwm.desktop /usr/share/xsessions/
