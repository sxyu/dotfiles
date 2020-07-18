#!/bin/bash
sudo apt update
sudo apt -y install ruby ruby-dev nodejs npm
sudo apt -y install xclip
sudo apt -y install net-tools axel
sudo apt -y install libxrandr-dev libxinerama-dev libxcursor-dev
sudo apt -y install rxvt-unicode-256color
sudo cp /usr/share/terminfo/r/rxvt-256color /usr/share/terminfo/r/rxvt-unicode-256color
cp /usr/share/terminfo/r/rxvt-unicode-256color ~/miniconda3/share/terminfo/r/
sudo cp -ar util/lib-urxvt-perl/* /usr/lib/x86_64-linux-gnu/urxvt/perl/
sudo apt -y install python3-dev python3-pip
sudo apt -y install clang clang-format cmake libclang-dev llvm-dev rapidjson-dev
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
mkdir -p ~/.vim/tmp
git submodule update --init --recursive
cd ~/builds/bspwm && git reset && make -j12 && sudo make install
cd ~/builds/sxhkd && git reset && make -j12 && sudo make install
cd ~/builds/jump && git reset && make -j12 && sudo install jump /usr/local/bin/jump
cd ~/builds/vim && git reset && ./configure --enable-rubyinterp --enable-python3interp && make -j12 && sudo make install
cd ~/builds/polybar && mkdir build
cd build
git submodule update --init --recursive
cmake .. -DCMAKE_BUILD_TYPE=Release
sudo make install
cd ~/builds/ccls && mkdir build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
sudo make install
sudo cp ~/builds/bspwm/contrib/freedesktop/bspwm.desktop /usr/share/xsessions/
cd ~/.vim/pack/default/start/command-t
rake make
