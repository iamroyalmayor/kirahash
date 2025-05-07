#!/usr/bin/env python3
import os
import re
from datetime import datetime

os.system("clear")
os.system("toilet -f pagga 'HASH DETECTOR' | lolcat")

hash_value = input("🔍 Enter the hash to analyze: ").strip()
length = len(hash_value)

# ======================
# LENGTH-BASED DETECTION
# ======================
length_map = {
    32: "MD5",
    40: "SHA1",
    64: "SHA256",
    128: "SHA512",
}

algo_by_length = length_map.get(length, "Unknown")

# =======================
# FORMAT-BASED DETECTION
# =======================
def format_based_detection(h):
    if re.match(r"^[a-fA-F0-9]{32}$", h):
        return "MD5"
    elif re.match(r"^[a-fA-F0-9]{40}$", h):
        return "SHA1"
    elif re.match(r"^[a-fA-F0-9]{64}$", h):
        return "SHA256"
    elif re.match(r"^[a-fA-F0-9]{128}$", h):
        return "SHA512"
    elif re.match(r"^\$2[aby]?\$\d+\$[./A-Za-z0-9]{53}$", h):
        return "bcrypt"
    elif re.match(r"^\$argon2", h):
        return "Argon2"
    elif re.match(r"^[A-Za-z0-9+/=]{24,}$", h):
        return "Possibly Base64 or AES Ciphertext"
    else:
        return "Unknown"

algo_by_format = format_based_detection(hash_value)

# =======================
# CONFIDENCE CALCULATION
# =======================
confidence = 100 if algo_by_format == algo_by_length and algo_by_length != "Unknown" else 75

print("\n🔎 Detection Results:")
print(f"📏 Algorithm by Length: {algo_by_length}")
print(f"🔣 Algorithm by Format: {algo_by_format}")
print(f"✅ Confidence Score: {confidence}%")

# =======================
# SAVE TO LOGS
# =======================
log_folder = os.path.expanduser("~/Desktop/kirahash_logs")
os.makedirs(log_folder, exist_ok=True)
with open(f"{log_folder}/hash_detection_log.txt", "a") as f:
    f.write(f"[{datetime.now()}] HASH: {hash_value} | Length: {length} | By Length: {algo_by_length} | By Format: {algo_by_format} | Confidence: {confidence}%\n")

input("\nPress Enter to return to main menu...")
os.system("kirahash")
