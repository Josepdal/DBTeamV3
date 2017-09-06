# **DBTeamV3** #

[![Library](https://img.shields.io/badge/TDLib-beta-brightgreen.svg)](https://core.telegram.org/tdlib)
[![Telegram-bot](https://img.shields.io/badge/TDCli-Bitbucket-green.svg)](https://valtman.name/telegram-bot)
[![Lua](https://img.shields.io/badge/Lua-5.2-blue.svg)](https://www.lua.org/)
[![Redis](https://img.shields.io/badge/Redis-3.2.8-red.svg)](https://redis.io/)
[![License](https://img.shields.io/badge/License-GNU%20GPL--3-yellow.svg)](https://github.com/Josepdal/DBTeamV1/blob/master/LICENSE)


### An administration Telegram bot using Telegram-cli

DBTeamV3 is a a powerful administration userbot that uses [telegram-bot](https://valtman.name/telegram-bot).  
It is programmed in [Lua](https://www.lua.org/) and uses the rapid [Redis](https://redis.io/) database.

The difference among the old [DBTeamV1](https://github.com/Josepdal/DBTeamV1) and [DBTeamV2](https://github.com/Josepdal/DBTeamV2) is that this one uses a much newer *Tg-Cli* with new stuff and also the bot has improved in usability, stability and has new functions.

Using [DBTeamV3](https://github.com/Josepdal/DBTeamV3) you will get all [DBTeamV2](https://github.com/Josepdal/DBTeamV2) features plus the latests telegram changes like calls, payments and so more. Of course, is working in every chat including channels.

# Summary

- Easy to setup and to update, no compilation needed.
- Uses a plugins system so you can easily configure or add what you need.
- Multilanguage and easy to add new languages.
- Has many funtions that normal bots are not able to do, e.g., read channels.
- Advanced moderation system.
- Has privilege ranges (sudo, admin, mod, user).
- Simple and intuitive command usages.
- Compatible with most of recent added telegram additions.
- Really fast and stable.
- Up-to-date documentation at http://telegra.ph/DBTeamV2-Tutorial-English-02-26


# Installation

Debian/Ubuntu and derivatives:
```bash
# Tested on Ubuntu 16.04
sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get install git redis-server lua5.2 liblua5.2-dev lua-lgi libnotify-dev unzip tmux -y && add-apt-repository ppa:ubuntu-toolchain-r/test && sudo apt-get update && apt-get upgrade && sudo apt-get install libconfig++9v5 libstdc++6 && sudo apt autoremove
```                   
In case of errors like `version GLIBCXX_3.4.21 not defined`, download manually libstdc++6 from [here](https://packages.ubuntu.com/xenial/libstdc++6), install the package with `dpkg -i` and repeat the previous step.

If you are not able to install the bot in Ubuntu 14, an upgrade to Ubuntu 16.04 is recommended. Upgrade from terminal: `sudo do-release-upgrade`

---------------------------------

After installing the dependencies, lets install the bot:
```bash
 git clone https://github.com/Josepdal/DBTeamV3.git
 cd DBTeamV3
 chmod +x launch.sh
 ./launch.sh install
 ./launch.sh login # Will ask you for a phone number & confirmation code.
 ./launch.sh
```

DBTeamV3 Developers:
--------------------
[![https://telegram.me/Josepdal](https://img.shields.io/badge/%F0%9F%92%AC_Telegram-Josepdal-blue.svg)](https://t.me/Josepdal)
[![https://telegram.me/Jarriz](https://img.shields.io/badge/%F0%9F%92%AC_Telegram-Jarriz-blue.svg)](https://t.me/Jarriz)
[![https://telegram.me/iicc1](https://img.shields.io/badge/%F0%9F%92%AC_Telegram-iicc1-blue.svg)](https://t.me/iicc1)

DBTeamV3 Channels:
--------------------
[![https://telegram.me/DBTeamEN](https://img.shields.io/badge/%F0%9F%92%AC_Telegram-DBTeamEN-blue.svg)](https://t.me/DBTeamEN)
[![https://telegram.me/DBTeamES](https://img.shields.io/badge/%F0%9F%92%AC_Telegram-DBTeamES-blue.svg)](https://t.me/DBTeamES)

Special thanks to:
==================
Yago Pérez and his telegram-bot
-------------------------------
[![https://telegram.me/Yago_Perez](https://img.shields.io/badge/%F0%9F%92%AC_Telegram-Yago_Perez-blue.svg)](https://t.me/Yago_Perez)
[![https://github.com/yagop/telegram-bot](https://img.shields.io/badge/%F0%9F%92%AC_GitHub-Telegram_bot-green.svg)](https://github.com/yagop/telegram-bot)


Riccardo and his GroupButler
----------------------------
[![https://telegram.me/Riccardo](https://img.shields.io/badge/%F0%9F%92%AC_Telegram-bac0nnn-blue.svg)](https://t.me/bac0nnn)
[![https://github.com/RememberTheAir/GroupButler](https://img.shields.io/badge/%F0%9F%92%AC_GitHub-GroupButler-green.svg)](https://github.com/RememberTheAir/GroupButler)


vysheng and his new telegram-bot
--------------------------
[![https://valtman.name/telegram-cli](https://img.shields.io/badge/%F0%9F%92%AC_WebPage-valtman.name-red.svg)](https://valtman.name/telegram-bot)
[![https://github.com/vysheng](https://img.shields.io/badge/%F0%9F%92%AC_GitHub-vysheng-green.svg)](https://github.com/vysheng)


rizaumami and his tdcli lib
---------------------------
[![https://github.com/rizaumami/tdcli.lua](https://img.shields.io/badge/%F0%9F%92%AC_GitHub-rizaumami-green.svg)](https://github.com/rizaumami/tdcli.lua)

Thanks to [@Reload_Life](https://t.me/Reload_Life) for [settings design](https://github.com/Reload-Life).
