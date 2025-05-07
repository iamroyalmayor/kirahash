#!/bin/bash

clear
toilet -f pagga "Brute Force" | lolcat
echo -e "\e[1;36m🔥 Welcome to the Brute Force Attack Module\e[0m"
echo ""
echo -e "\e[1;33mChoose the attack type:\e[0m"

echo -e "\e[1;32m1) Dictionary Attack\e[0m"
echo -e "   🔍 Try passwords from a wordlist to find a match (fastest if the password is weak or common)"
echo ""

echo -e "\e[1;32m2) Pure Brute Force Attack\e[0m"
echo -e "   💣 Tries every possible character combination — powerful but slow"
echo ""

echo -e "\e[1;32m3) Hybrid Attack\e[0m"
echo -e "   🧬 Perform Brute force Attark "
echo ""

echo -e "\e[1;31m0) Back to Main Menu\e[0m"
echo ""

read -p $'\e[1;34mSelect an option: \e[0m' choice

case $choice in
    1)
        bash bruteforce/dictionary.sh
        ;;
    2)
        bash bruteforce/pure.sh
        ;;
    3)
        bash bruteforce/hybrid.sh
        ;;
    0)
        kirahash
        ;;
    *)
        echo -e "\n\e[1;31mInvalid choice. Please try again.\e[0m"
        sleep 2
        bash modules/brute_force.sh
        ;;
esac
