files[1]=".bashrc"
files[2]=".bash_profile"
files[3]=".bash_path"
files[4]=".bash_prompt"
files[5]=".bash_exports"
files[6]=".bash_aliases"
files[7]=".bash_functions"
files[8]=".bash_extra"
files[9]=".curlrc"
files[10]=".editorconfig"
files[11]=".gitattributes"
files[12]=".gitconfig"
files[13]=".gitignore"
files[14]=".gvimrc"
files[15]=".inputrc"
files[16]=".screenrc"
files[17]=".vimrc"
files[18]=".wgetrc"
files[19]=".vim"


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

    if [ -r "$PWD/$file" ] && [ -f "$PWD/$file" -o -d "$PWD/$file" ]; then
        if [ -r "$toDir/$file" ];then

            cp -Rv "$toDir/$file" "$backupDir/$file"

            echo "unlink $toDir/$file"
            unlink "$toDir/$file"
        fi

        echo "ln -s $PWD/$file $toDir/$file"
        ln -s "$PWD/$file" "$toDir/$file"
    fi

    unset toDir
    unset backupDir
done;


if [ ! -d "$HOME/bin" ]; then
	mkdir -pv "$HOME/bin"
fi

curl -O https://raw.githubusercontent.com/git/git/master/contrib/diff-highlight/diff-highlight

chmod +x "$PWD/diff-highlight"

# устанавливаем ссылку на правильный диф-хайлатер
ln -s "$PWD/diff-highlight" "$HOME/bin/diff-highlight"

unset files;
