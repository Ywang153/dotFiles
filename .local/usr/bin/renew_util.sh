#!/usr/bin/env bash 
clear

DIRTEMP=$MYPREFIX/tmp
DIRBIN=$MYPREFIX/bin
DIRPLUGIN=$MYPREFIX/usr/plugin

[ -d "$DIRPLUGIN"   ] || mkdir -p $DIRPLUGIN
[ -d "$DIRBIN"      ] || mkdir -p $DIRBIN
[ -d "$DIRTEMP"     ] || mkdir -p $DIRTEMP

DIRORIG=$(pwd)

case "$1" in
    "init")
        echo -e "\033[33mBegain to initialize personal environment..\n\033[0m"

        sudo mkdir -p /data/{Apps,Temp,CodeZone/{3rdparty,GITROOT},Packages,VMs}
        sudo chown -R "$(whoami)": /data/*
        
        chmod 700 ~/.ssh/ && chmod -R 600 ~/.ssh/*
        cd
        
        [ -L "tmp" ] || ln -s /data/Temp tmp
        [ -L "data" ] || ln -s /data data
        
        echo -e "\033[32m\nDone\033[0m"
        ;;
        
    "install-tools")
        echo -e "\033[33mBegain to initialize personal environment..\n\033[0m"
        
        ## install or update autojump
        echo -e "\033[34m\nStart to install autojump...\033[0m"

        AUTOJUMP=autojump

        if [ ! -d "$DIRTEMP/$AUTOJUMP" ]; then
            git clone --progress git://github.com/wting/${AUTOJUMP}.git $DIRTEMP/$AUTOJUMP
        fi

        cd $DIRTEMP/$AUTOJUMP
        git pull && ./install.py


        if [ ${OSTYPE:0:6} != "cygwin"  ] ; then
            ## install or update fzf, for fzf not support mintty yet
            echo -e "\033[34m\nStart to install fzf...\033[0m"

            FZF=fzf

            if [ ! -d "$DIRTEMP/$FZF" ]; then
                git clone --progress git://github.com/junegunn/${FZF}.git $DIRTEMP/$FZF
            fi

            cd $DIRTEMP/$FZF
            git pull && yes | ./install --no-update-rc    
            
            ## https://joplinapp.org/terminal/
            #echo -e "\033[34m\nStart to install Joplin...\033[0m"
            #NPM_CONFIG_PREFIX=$DIRTEMP/Joplin
            #sudo npm install -g joplin
            #ln -s $DIRTEMP/Joplin/bin/joplin $DIRBIN/joplin
        fi
        
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
        if [ -L "data" ]; then
            cd $HOME/data/CodeZone/GITROOT/
            
            [ -d "Partime"   ] || git clone https://e.coding.net/glenn/Partime.git Partime
            [ -d "Sample"   ] || git clone https://github.com/Ywang153/Sample.git Sample
            [ -d "Doc"   ] || git clone https://github.com/Ywang153/Doc.git Doc

            cd $HOME/data/CodeZone/3rdparty/
            
            [ -d "putty-color-themes"   ] || git clone https://github.com/AlexAkulov/putty-color-themes.git putty-color-themes
            [ -d "test_db"   ] || git clone https://github.com/datacharmer/test_db.git test_db
        else
            echo -e "\033[35mNot found the target directory, Please try <$(basename -- $0) init> first!\n\033[0m"
        fi
        
        ;;

    *)       
        echo -e "\033[37mUsage: \n\t$(basename -- $0) <init|install-tools|install-debain-based-pkg|install-arch-with-kde-pkg|git-workflow>\n\033[0m"
        ;;
esac
   
## return back to the orignal directory
cd $DIRORIG

