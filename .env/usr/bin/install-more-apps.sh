clear
echo -e "\033[35mTry to install more applications according to the specific environment.\033[0m"

if [ -x "$(command -v apt)" ]; then
    echo -e "\033[33m\nStart to install apt packages...\033[0m"
    sudo apt install -y "$(check-language-support)"
    sudo apt install -y wireshark
fi

if [ -x "$(command -v snap)" ]; then
    echo -e "\033[33m\nStart to install snap packages...\033[0m"

    sudo snap install pycharm-community --classic
    sudo snap install clion --classic
    sudo snap install bash-language-server --classic
    sudo snap install code --classic
    sudo snap install glow
    sudo snap install shotcut --classic
    sudo snap install chromium
    sudo snap install gimp
    sudo snap install dbeaver-ce
fi

if [ -x "$(command -v dnf)" ]; then
    echo -e "\033[33m\nStart to install dnf packages...\033[0m"
fi

if [ -x "$(command -v pacman)" ]; then
    echo -e "\033[33m\nStart to install pacman packages...\033[0m"
fi

if [ -x "$(command -v wget)" ]; then
    echo -e "\033[33m\nStart to install Joplin...\033[0m"
    wget -t 0 -c -O - https://raw.githubusercontent.com/laurent22/joplin/dev/Joplin_install_and_update.sh | bash

    echo -e "\033[33m\nStart to install Miniconda3...\033[0m"
    wget -t 0 -c https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /private/data/Temp/miniconda.sh
    bash /private/data/Temp/miniconda.sh -b -u -p /private/data/Apps/Miniconda3
    rm /private/data/Temp/miniconda.sh
fi

echo -e "\033[32m\nDone\033[0m"
