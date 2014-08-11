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

# 生成英文字符集
#export LC_ALL=en_US.UTF-8
#export LANG=en_US.UTF-8

sudo localedef -i en_US -f UTF-8 en_US.UTF-8

