#!/bin/bash
# Launch created by @Jarriz, @Josepdal and @iicc1

tgcli_version=170831
luarocks_version=2.4.2

lualibs=(
'luasec'
'luarepl'
'lbase64 20120807-3'
'luafilesystem'
'lub'
'luaexpat'
'redis-lua'
'lua-cjson'
'fakeredis'
'xml'
'feedparser'
'serpent'
)

today=`date +%F`

get_sub() {
    local flag=false c count cr=$'\r' nl=$'\n'
    while IFS='' read -d '' -rn 1 c; do
        if $flag; then
            printf '%c' "$c"
        else
            if [[ $c != $cr && $c != $nl ]]; then
                count=0
            else
                ((count++))
                if ((count > 1)); then
                    flag=true
                fi
            fi
        fi
    done
}

make_progress() {
exe=`lua <<-EOF
    print(tonumber($1)/tonumber($2)*100)
EOF
`
    echo ${exe:0:4}
}

function download_libs_lua() {
    if [[ ! -d "logs" ]]; then mkdir logs; fi
    if [[ -f "logs/logluarocks_${today}.txt" ]]; then rm logs/logluarocks_${today}.txt; fi
    local i
    for ((i=0;i<${#lualibs[@]};i++)); do
        printf "\r\33[2K"
        printf "\rDBTeam: wait... [`make_progress $(($i+1)) ${#lualibs[@]}`%%] [$(($i+1))/${#lualibs[@]}] ${lualibs[$i]}"
        ./.luarocks/bin/luarocks install ${lualibs[$i]} &>> logs/logluarocks_${today}.txt
    done
    sleep 0.2
    printf "\nLogfile created: $PWD/logs/logluarocks_${today}.txt\nDone\n"
    rm -rf luarocks-2.2.2*
}

function configure() {
    if [[ -f "/usr/bin/lua5.3" ]] || [[ -f "/usr/bin/lua5.1" ]] || [[ -f "/usr/local/bin/lua5.3" ]]; then
        echo -e "\033[0;31mError\033[0m":\
        "DBTeam ins't working with lua5.3 and others versions, the packages must be removed,"\
        "please remove them, reinstall lua5.2 and run launch.sh again."
        exit 1
    fi
    dir=$PWD
    wget http://luarocks.org/releases/luarocks-${luarocks_version}.tar.gz &>/dev/null
    tar zxpf luarocks-${luarocks_version}.tar.gz &>/dev/null
    cd luarocks-${luarocks_version}
    if [[ ${1} == "--no-null" ]]; then
        ./configure --prefix=$dir/.luarocks --sysconfdir=$dir/.luarocks/luarocks --force-config
        make bootstrap
    else
        ./configure --prefix=$dir/.luarocks --sysconfdir=$dir/.luarocks/luarocks --force-config &>/dev/null
        make bootstrap &>/dev/null
    fi
    cd ..; rm -rf luarocks*
    if [[ ${1} != "--no-download" ]]; then
        download_libs_lua
        wget --progress=bar:force https://valtman.name/files/telegram-bot-${tgcli_version}-linux 2>&1 | get_sub
        if [ ! -d "bin" ]; then mkdir bin; fi
        mv telegram-bot-${tgcli_version}-linux telegram-bot; chmod +x telegram-bot
    fi
    for ((i=0;i<101;i++)); do
        printf "\rConfiguring... [%i%%]" $i
        sleep 0.007
    done
    mkdir $HOME/.telegram-bot; cat <<EOF > $HOME/.telegram-bot/config
default_profile = "main";

main = {
  lua_script = "$HOME/DBTeamV3/bot/bot.lua";
};
EOF
    printf "\nDone\n"
}

function start_bot() {
    ./telegram-bot
}

function login_bot() {
    ./telegram-bot -p main --login --phone=${1}
}

function show_logo_slowly() {
    seconds=0.009
    logo=(
    " ____  ____ _____"
    "|    \|  _ )_   _|___ ____   __  __"
    "| |_  )  _ \ | |/ .__|  _ \_|  \/  |"
    "|____/|____/ |_|\____/\_____|_/\/\_|  v3"
    "by @Josepdal @iicc1 and @Jarriz"
    )
    printf "\033[38;5;208m\t"
    local i x
    for i in ${!logo[@]}; do
        for ((x=0;x<${#logo[$i]};x++)); do
            printf "${logo[$i]:$x:1}"
            sleep $seconds
        done
        printf "\n\t"
    done
    printf "\n"
}

function show_logo() {
    #Adding some color. By @iicc1 :D
    echo -e "\033[38;5;208m"
    echo -e "\t ____  ____ _____"
    echo -e "\t|    \|  _ )_   _|___ ____   __  __"
    echo -e "\t| |_  )  _ \ | |/ .__|  _ \_|  \/  |"
    echo -e "\t|____/|____/ |_|\____/\_____|_/\/\_|  v3"
    echo -e "\n\e[36m"
}

case $1 in
    install)
    	show_logo_slowly
    	configure ${2}
    exit ;;
    login)
        echo "Please enter your phone number: "
        read phone_number
        login_bot ${phone_number}
    exit ;;
esac


show_logo
start_bot $@
exit 0
