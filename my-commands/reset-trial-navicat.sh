#!/bin/bash

# Author: NakamuraOS <https://github.com/nakamuraos>
# Latest update: 06/24/2024
# Tested on Navicat 15.x, 16.x, 17.x on Debian, Ubuntu.

BGRED="\e[1;97;41m"
ENDCOLOR="\e[0m"

echo -e "${BGRED}                                            ${ENDCOLOR}"
echo -e "${BGRED}  ┌──────────────────────────────────────┐  ${ENDCOLOR}"
echo -e "${BGRED}  │            !!! WARNING !!!           │  ${ENDCOLOR}"
echo -e "${BGRED}  ├──────────────────────────────────────┤  ${ENDCOLOR}"
echo -e "${BGRED}  │      ALL DATA can be destroyed.      │  ${ENDCOLOR}"
echo -e "${BGRED}  │   Always BACKUP before continuing.   │  ${ENDCOLOR}"
echo -e "${BGRED}  └──────────────────────────────────────┘  ${ENDCOLOR}"
echo -e "${BGRED}                                            ${ENDCOLOR}"

echo -e "Report issues:\n> https://gist.github.com/nakamuraos/717eb99b5e145ed11cd754ad3714b302\n"
echo -e "Reset trial \e[1mNavicat Premium\e[0m:"
read -p "Are you sure? (y/N) " -r
echo
if [[ $REPLY =~ ^[Yy]([eE][sS])?$ ]]
then
  echo "Starting reset..."
  DATE=$(date '+%Y%m%d_%H%M%S')
  # Backup
  echo "=> Creating a backup..."
  cp ~/.config/dconf/user ~/.config/dconf/user.$DATE.bk
  echo "The user dconf backup was created at $HOME/.config/dconf/user.$DATE.bk"
  cp ~/.config/navicat/Premium/preferences.json ~/.config/navicat/Premium/preferences.json.$DATE.bk
  echo "The Navicat preferences backup was created at $HOME/.config/navicat/Premium/preferences.json.$DATE.bk"
  # Clear data in dconf
  echo "=> Resetting..."
  dconf reset -f /com/premiumsoft/navicat-premium/
  echo "The user dconf data was reset"
  # Remove data fields in config file
  sed -i -E 's/,?"([A-F0-9]+)":\{([^\}]+)},?//g' ~/.config/navicat/Premium/preferences.json
  echo "The Navicat preferences was reset"
  # Done
  echo "Done."
else
  echo "Aborted."
fi