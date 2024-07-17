if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi
target="$1"
while [ 1 ]
do
    echo trying to install "$target"
    
    if [[ $(port installed "$target" | grep "$target") ]];
    then
        echo "$target" present; break;
    fi
    
    line=`yes | port install "$target" 2>&1 > /dev/tty | grep "port -f activate"`
    package=$(echo $line | sed -e "s/^.*port -f activate //" -e "s/. .*//")
    
    if [ "$package" = "$oldpackage" ];
    then
        echo double \""$package"\"; break;
    fi
    
    echo activating "$package"
    
    oldpackage="$package"
    port -f activate "$package"
done

