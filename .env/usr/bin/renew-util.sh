#!/usr/bin/env bash 
clear

DIRPRIVATE=/private/data
DIRTEMP=$MYPREFIX/tmp
DIRBIN=$MYPREFIX/bin
DIRPLUGIN=$MYPREFIX/usr/plugin

[ -d "$DIRPLUGIN"   ] || mkdir -p $DIRPLUGIN
[ -d "$DIRBIN"      ] || mkdir -p $DIRBIN
[ -d "$DIRTEMP"     ] || mkdir -p $DIRTEMP

DIRORIG=$(pwd)

case "$1" in
    "init-env")
        echo -e "\033[33mBegain to initialize personal setting..\n\033[0m"

        chmod 700 ~/.ssh/ && chmod -R 600 ~/.ssh/*
        
        echo -e "\033[32m\nDone\033[0m"
        ;;
        
    "init-working-tree")
        echo -e "\033[33mBegain to create directory tree..\n\033[0m"

        sudo mkdir -p $DIRPRIVATE/{Apps,Temp,DevZone/{3rdparty,GITROOT},Packages,VMs}
        sudo chown -R "$(whoami)": $DIRPRIVATE/*
        
        cd
        
        [ -L "tmp" ] || ln -s $DIRPRIVATE/Temp tmp
        [ -L "dev" ] || ln -s $DIRPRIVATE/DevZone dev
        
        echo -e "\033[32m\nDone\033[0m"
        ;;
        
    "install-tools")
        echo -e "\033[33mBegain to initialize personal environment..\n\033[0m"
        echo -e "\033[32m\nDone\033[0m"
        ;;
    
    "install-debain-based-pkg")
        ## install common packages on debian base destro
        echo -e "\033[33m\nStart to install packages...\n\033[0m"
                    
        if [ -f "$MYPREFIX/usr/doc/pkglist/debian-based-distro" ]; then
            sudo apt update -y 
            xargs sudo apt install -y < $MYPREFIX/usr/doc/pkglist/debian-based-distro
        fi
        
        echo -e "\033[32m\nDone\033[0m"
        ;;            
    
    "install-rhel-based-pkg")
        ## install common packages on rhel base destro
        echo -e "\033[33m\nStart to install packages...\n\033[0m"
                    
        if [ -f "$MYPREFIX/usr/doc/pkglist/rhel-based-distro" ]; then
            sudo dnf update -y 
            sudo dnf group install -y "C Development Tools and Libraries" "Development Tools" "Development Libraries"
            xargs sudo dnf install -y < $MYPREFIX/usr/doc/pkglist/rhel-based-distro
        fi
        
        echo -e "\033[32m\nDone\033[0m"
        ;;            
    
    "install-arch-with-kde-pkg")
        ## install common packages on arch linux base destro
        echo -e "\033[33m\nStart to install packages...\n\033[0m"
                    
        if [ -f "$MYPREFIX/usr/doc/pkglist/arch-based-distro-with-kde" ]; then
            # sudo pacman-mirrors -c all
            sudo pacman-mirrors -i -c China -m rank
            sudo pacman -Syy --noconfirm
            sudo pacman -S archlinuxcn-keyring --noconfirm
            sudo pacman -S --needed --noconfirm - < $MYPREFIX/usr/doc/pkglist/arch-based-distro-with-kde
        fi
        
        echo -e "\033[32m\nDone\033[0m"
        ;;

    "git-workflow")
        if [ -d "$HOME/dev/GITROOT" ]; then
            cd $HOME/dev/GITROOT/
            
            [ -d "myTrader"   ] || git clone https://gitee.com/wangyuhuai/myTrader.git myTrader
            [ -d "Sample"   ] || git clone https://github.com/Ywang153/Sample.git Sample

            cd $HOME/dev/3rdparty/
            
            [ -d "putty-color-themes"   ] || git clone https://github.com/AlexAkulov/putty-color-themes.git putty-color-themes
            [ -d "test_db"   ] || git clone https://github.com/datacharmer/test_db.git test_db
        else
            echo -e "\033[35mNot found the target directory, Please try <$(basename -- $0) init-working-tree> first!\n\033[0m"
        fi
        
        ;;

    *)       
        echo -e "\033[37mUsage: \n\t$(basename -- $0) <init-env|init-working-tree|install-tools|install-debain-based-pkg|install-rdhl-based-pkg|install-arch-with-kde-pkg|git-workflow>\n\033[0m"
        ;;
esac
   
## return back to the orignal directory
cd $DIRORIG

