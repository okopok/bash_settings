files[1]=".bashrc"
files[2]=".bash_profile"
files[3]=".bash_path"
files[4]=".bash_prompt"
files[5]=".bash_exports"
files[6]=".bash_aliases"
files[7]=".bash_functions"
files[8]=".bash_extra"
files[9]=".bash_colours"

while true; do
    echo "----------------------------------"
    echo "Будут заменены следующие файлы"
    printf -- "%s\n" ${files[*]}
    echo "--"
    read -p "Вы хотите продолжить? [Y/n]: " yn
    case $yn in
        [Yy]* ) echo '---'; break;;
        [Nn]* ) unset files; return;  break;;
        * ) echo "Please answer yes or no.";;
    esac
done

for file in ${files[*]}; do

    toDir="$HOME"
    backupDir="$PWD/backup/`date +%s`"
    if [ ! -d "$backupDir" ]; then
        mkdir -pv $backupDir
    fi

    if [ -r "$PWD/$file" ] && [ -f "$PWD/$file" ]; then
        if [ -r "$toDir/$file" ];then

            echo "cp $toDir/$file $backupDir/$file"
            cp "$toDir/$file" "$backupDir/$file"

            echo "unlink $toDir/$file"
            unlink "$toDir/$file"
        fi

        echo "ln -s $PWD/$file $toDir/$file"
        ln -s "$PWD/$file" "$toDir/$file"
    fi

    unset toDir
    unset backupDir
done;
unset files;
