#!/bin/bash

clear
toilet -f pagga "Pure Brute Force" | lolcat
echo -e "\e[1;36m🚀 Welcome to Pure Brute Force Attack Module\e[0m"
echo ""

read -p $'\e[1;33mEnter the hash to crack: \e[0m' target_hash
echo -e "\e[1;34m[+] Detecting hash algorithm...\e[0m"

# Function to detect hash type
detect_hash_type() {
    len=${#target_hash}
    case $len in
        32) echo "md5" ;;
        40) echo "sha1" ;;
        64) echo "sha256" ;;
        128) echo "sha512" ;;
        *) echo "unknown" ;;
    esac
}

hash_type=$(detect_hash_type)

if [ "$hash_type" == "unknown" ]; then
    read -p $'\e[1;31mCould not detect hash type. Please enter manually (md5/sha1/sha256/sha512): \e[0m' hash_type
fi

echo -e "\e[1;32m[✔] Detected/Selected hash type: $hash_type\e[0m"

echo -e "\n\e[1;33mSelect character set:\e[0m"
echo -e "1) Lowercase letters (a-z)"
echo -e "2) Alphanumeric (a-z, A-Z, 0-9)"
echo -e "3) Alphanumeric + symbols (!@#...)"
read -p $'\e[1;34mChoice: \e[0m' charset_choice

case $charset_choice in
    1) charset="abcdefghijklmnopqrstuvwxyz" ;;
    2) charset="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789" ;;
    3) charset="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#\$%^&*()-_=+" ;;
    *) echo -e "\e[1;31mInvalid option. Exiting.\e[0m"; exit 1 ;;
esac

read -p $'\e[1;33mEnter max password length (e.g., 4): \e[0m' maxlen

echo -e "\n\e[1;34m[!] Starting brute force attack... This may take a while.\e[0m"

found=false

bruteforce() {
    local chars=$1
    local max=$2
    local prefix=$3

    for c in $(echo "$chars" | fold -w1); do
        try="$prefix$c"

        # Hash and compare
        case $hash_type in
            md5) h=$(echo -n "$try" | md5sum | awk '{print $1}') ;;
            sha1) h=$(echo -n "$try" | sha1sum | awk '{print $1}') ;;
            sha256) h=$(echo -n "$try" | sha256sum | awk '{print $1}') ;;
            sha512) h=$(echo -n "$try" | sha512sum | awk '{print $1}') ;;
        esac

        if [ "$h" == "$target_hash" ]; then
            echo -e "\n\e[1;32m✅ Match found: $try\e[0m"
            found=true
            echo "[$(date)] Hash: $target_hash | Password: $try" >> ~/Desktop/kirahash_logs/bruteforce_matches.txt
            return 0
        fi

        if [ ${#try} -lt $max ]; then
            bruteforce "$chars" $max "$try"
            if [ "$found" = true ]; then return 0; fi
        fi
    done
}

bruteforce "$charset" $maxlen ""

if [ "$found" = false ]; then
    echo -e "\n\e[1;31m❌ No match found. Try increasing max length or using a different charset.\e[0m"
fi

echo ""
read -p $'\e[1;33mTry again? (y/n): \e[0m' retry
if [[ "$retry" == "y" || "$retry" == "Y" ]]; then
    bash bruteforce/pure.sh
else
    bash modules/brute_force.sh
fi
