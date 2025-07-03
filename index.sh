#!/bin/bash

# Get the absolute path of the script
SCRIPT_PATH="$(readlink -f "$0")"
SCRIPT_DIR="$(dirname "$SCRIPT_PATH")"


# Clear screen
clear

# Load the logo
toilet -f pagga -F border "KIRAHASH" | lolcat
echo -e "\033[1;36mWelcome to Kirahash - Password & Hashing Toolkit\033[0m"
echo -e "\033[0;33mCreated by iamroyalmayor | Powered by Spectrum Solutions\033[0m"
echo ""

# Menu banner
echo -e "\033[1;34m==================== MAIN MENU ====================\033[0m"
echo -e "\033[1;32m[1]\033[0m Detect Hash Algorithm"
echo -e "\033[1;32m[2]\033[0m Encode Password"
echo -e "\033[1;32m[3]\033[0m Decode Password"
echo -e "\033[1;32m[4]\033[0m Check Password Strength"
echo -e "\033[1;32m[5]\033[0m Run Brute Force Attack"
echo -e "\033[1;32m[6]\033[0m Exit"
echo -e "\033[1;34m==================================================\033[0m"
echo ""

# Ask for input
read -p $'\033[1;33mChoose your option (1-6): \033[0m' option

# Handle choices
case $option in
    1)
        python3 "$SCRIPT_DIR/modules/detect_hash.py"
        ;;
    2)
        python3 "$SCRIPT_DIR/modules/encode_password.py"
        ;;
    3)
        bash "$SCRIPT_DIR/modules/decode_hash.sh"
        ;;
    4)
        python3 "$SCRIPT_DIR/modules/password_strength.py"
        ;;
    5)
        bash "$SCRIPT_DIR/modules/brute_force.sh"
        ;;
    6)
        echo -e "\033[1;31mExiting Kirahash... Stay secure!\033[0m"
        exit 0
        ;;
    *)
        echo -e "\033[1;31mInvalid option. Please select from 1-6.\033[0m"
        sleep 2
        bash "$SCRIPT_DIR/index.sh"
        ;;
esac
