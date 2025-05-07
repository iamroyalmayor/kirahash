#!/usr/bin/env python3
import os
import re
import sys
from datetime import datetime

# Display Logo using toilet and lolcat
os.system("clear")
os.system("toilet -f future 'HASH DETECTOR' | lolcat")
print("\nWelcome to the Hash Detection Module!\n")

# Ask user for input
hash_input = input("Enter the hash value: ").strip()

# --------- Detection by Length ----------
def detect_by_length(h):
    length = len(h)
    if length == 32:
        return "MD5"
    elif length == 40:
        return "SHA1"
    elif length == 64:
        return "SHA256"
    elif length == 96:
        return "SHA384"
    elif length == 128:
        return "SHA512"
    elif length == 88:
        return "AES"
    return "Unknown"

# --------- Detection by Format ----------
def detect_by_format(h):
    if re.fullmatch(r"[a-fA-F0-9]{32}", h):
        return "MD5"
    elif re.fullmatch(r"[a-fA-F0-9]{40}", h):
        return "SHA1"
    elif re.fullmatch(r"[a-fA-F0-9]{64}", h):
        return "SHA256"
    elif re.fullmatch(r"[a-fA-F0-9]{96}", h):
        return "SHA384"
    elif re.fullmatch(r"[a-fA-F0-9]{128}", h):
        return "SHA512"
    elif re.fullmatch(r"[A-Za-z0-9+/=]{88}", h):
        return "AES"
    return "Unknown"

# Perform detection
by_length = detect_by_length(hash_input)
by_format = detect_by_format(hash_input)

# Confidence score
confidence = 100 if by_length == by_format and by_length != "Unknown" else 75

# Output result
print(f"\n🔍 Algorithm based on length: {by_length}")
print(f"🔎 Algorithm based on format: {by_format}")
print(f"✅ Confidence rate: {confidence}%\n")

# Save to logs
log_folder = os.path.expanduser("~/Desktop/kirahash_logs")
os.makedirs(log_folder, exist_ok=True)
log_file = os.path.join(log_folder, "hash_detection.txt")
with open(log_file, "a") as f:
    f.write(f"[{datetime.now()}] HASH: {hash_input} | Length: {by_length} | Format: {by_format} | Confidence: {confidence}%\n")

# Return to main menu
input("Press Enter to return to the main menu...")
os.system("kirahash")
