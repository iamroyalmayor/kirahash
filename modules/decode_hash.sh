#!/bin/bash

clear
toilet -f pagga "Dictionary Attack" | lolcat
echo -e "\e[1;36m🔐 Attempting to crack hash using dictionary attack\e[0m\n"

# Prompt for hash input
read -p $'\e[1;33mEnter the hash to crack: \e[0m' target_hash

# === Auto Detect Hash Algorithm ===
hashlen=${#target_hash}
if [[ $target_hash =~ ^[a-fA-F0-9]+$ ]]; then
    case $hashlen in
        32) algo="md5" ;;
        40) algo="sha1" ;;
        64) algo="sha256" ;;
        128) algo="sha512" ;;
        *) algo="unknown" ;;
    esac
else
    algo="unknown"
fi

if [ "$algo" == "unknown" ]; then
    read -p $'\e[1;31m❓ Unable to auto-detect hash algorithm. Please enter manually (md5/sha1/sha256/sha512): \e[0m' algo
else
    echo -e "\n\e[1;32m✅ Detected Algorithm: $algo\e[0m"
fi

# === List Available Wordlists ===
echo -e "\n\e[1;34mAvailable Wordlists:\e[0m"
mapfile -t wordlists < <(ls wordlists/)
for i in "${!wordlists[@]}"; do
    echo -e "\e[1;32m$((i+1)))\e[0m ${wordlists[$i]}"
done
echo -e "\e[1;32m0)\e[0m Enter custom wordlist path"

read -p $'\n\e[1;33mChoose a wordlist: \e[0m' choice

if [[ "$choice" == "0" ]]; then
    read -p $'\e[1;33mEnter full path to your wordlist: \e[0m' selected_path
    wordlists=("$selected_path")
else
    selected_path="wordlists/${wordlists[$((choice-1))]}"
    selected_index=$((choice-1))
fi

# === Function to Try Cracking ===
try_crack() {
    local file=$1
    while read -r word; do
        word=$(echo -n "$word" | tr -d '\r\n')
        case $algo in
            md5) hash=$(echo -n "$word" | md5sum | awk '{print $1}') ;;
            sha1) hash=$(echo -n "$word" | sha1sum | awk '{print $1}') ;;
            sha256) hash=$(echo -n "$word" | sha256sum | awk '{print $1}') ;;
            sha512) hash=$(echo -n "$word" | sha512sum | awk '{print $1}') ;;
            *) echo -e "\e[1;31mUnsupported algorithm.\e[0m"; exit 1 ;;
        esac
        if [ "$hash" == "$target_hash" ]; then
            echo -e "\n\e[1;32m✅ Hash cracked! The password is: \e[1;33m$word\e[0m"
            echo "[$(date)] $target_hash cracked with $file → $word" >> ~/Desktop/kirahash_logs/decode_hash.txt
            return 0
        fi
    done < "$file"
    return 1
}

# === Try Selected Wordlist First ===
echo -e "\n🔍 Trying wordlist: \e[1;36m$selected_path\e[0m"
if try_crack "$selected_path"; then
    echo ""
else
    echo -e "\n\e[1;31m❌ No match found in selected wordlist.\e[0m"
    
    # === Try Remaining Wordlists Automatically ===
    if [[ "$choice" != "0" ]]; then
        for i in "${!wordlists[@]}"; do
            if [[ $i -ne $selected_index ]]; then
                path="wordlists/${wordlists[$i]}"
                echo -e "\n🔄 Trying next wordlist: \e[1;36m$path\e[0m"
                if try_crack "$path"; then
                    break
                fi
            fi
        done
    fi
fi

echo ""
read -p $'\e[1;34m🔁 Try again? (y/n): \e[0m' again
if [[ "$again" == "y" || "$again" == "Y" ]]; then
   bash modules/decode_hash.sh
else
    bash modules/decode_hash.sh
fi
