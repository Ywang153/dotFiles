# /etc/fstab
<Windows Path>                                        <Mount Point>    ntfs binary,posix=0,user,auto

127.0.0.1 localhost localhost.localdomain localhost4 localhost4.localdomain4 <your hostname>
::1 localhost localhost.localdomain localhost6 localhost6.localdomain6 <your hostname>

# Vim configure 
rm ./src/auto/config.cache

./configure --with-features=huge --enable-pythoninterp=yes --enable-python3interp=yes --enable-perlinterp=yes --enable-gui=auto --enable-cscope --enable-luainterp=yes --enable-multibyte --enable-rubyinterp=yes 

#Install list of packages using apt
#https://linux4one.com/how-to-list-installed-packages-on-ubuntu/
xargs sudo apt install -y < debian-family-pkglist

#Install list of packages using pacman
https://wiki.archlinux.org/index.php/Pacman/Tips_and_tricks

# Remove all files/directories except for one file
# https://unix.stackexchange.com/questions/153862/remove-all-files-directories-except-for-one-file
rm -- !(file.txt)

# To remove all backgroud colors
eval "$(dircolors -p | \
    sed 's/ 4[0-9];/ 01;/; s/;4[0-9];/;01;/g; s/;4[0-9] /;01 /' | \
    dircolors /dev/stdin)"

# lantern
https://raw.githubusercontent.com/getlantern/lantern-binaries/master/lantern-installer-64-bit.deb

# https://superuser.com/questions/1462281/how-to-remove-base-from-powershell
conda config --set auto_activate_base false

# arch based destro
https://github.com/archlinuxcn/repo
https://github.com/archlinuxcn/mirrorlist-repo

sudo pacman-mirrors -g // 更新源列表
sudo pacman-mirrors -i -c China -m rank //选择国内源
sudo pacman -Syyu --overwrite \*  // 更新pacman数据库并全面更新系统

# /etc/pacman.conf
[archlinuxcn]
SigLevel = Optional TrustedOnly
Server = https://mirrors.sjtug.sjtu.edu.cn/archlinux-cn/$arch

# 如何在安装后更改我的Cygwin主文件夹？
# https://stackoverflow.com/questions/1494658/how-can-i-change-my-cygwin-home-folder-after-installation
cd ~;echo "db_home: `pwd`" >> /etc/nsswitch.conf

# Test github.com via ssh
ssh -T git@github.com

# How to build YouCompleteMe in Cygwin? 
    Ensure node, go, mono and typescript API are installed and in your PATH, I assume you entered the <YouCompleteme> installed directory firstly, 
  and please follow below guide. Thanks.
  
  1), at begin, you need to check out all submodules, type the below command:
    git submodule update --init --recursive 

  2), to resolve the LONG_BIT issue, override the file wrap_python.hpp with cygwin's version, type the below command;
    cp /usr/include/boost/python/detail/wrap_python.hpp third_party/ycmd/cpp/BoostParts/boost/python/detail/wrap_python.hpp

  3), make sure the clang library could be found, you need to add the flag DEXTERNAL_LIBCLANG_PATH to the CMake, open the file third_party/ycmd/build.py, and search for cmake_args, and change it to like below:
    cmake_args = ['-DEXTERNAL_LIBCLANG_PATH=/usr/lib/libclang.dll.a']

  4), now, you could type the below command to build it, everything should be fine. 
    ./install.py --clang-completer --omnisharp-completer --gocode-completer --tern-completer
