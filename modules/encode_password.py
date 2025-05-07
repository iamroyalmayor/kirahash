#!/usr/bin/env python3
import hashlib
import os
from datetime import datetime

os.system("clear")
os.system("toilet -f pagga 'ENCODER' | lolcat")
print("🔐 Encode your password with modern hashing algorithms.\n")

text = input("Enter password to encode: ").strip()

md5 = hashlib.md5(text.encode()).hexdigest()
sha1 = hashlib.sha1(text.encode()).hexdigest()
sha256 = hashlib.sha256(text.encode()).hexdigest()
sha512 = hashlib.sha512(text.encode()).hexdigest()

print(f"\nMD5: {md5}")
print(f"SHA1: {sha1}")
print(f"SHA256: {sha256}")
print(f"SHA512: {sha512}")

log_folder = os.path.expanduser("~/Desktop/kirahash_logs")
os.makedirs(log_folder, exist_ok=True)
with open(f"{log_folder}/encoded_passwords.txt", "a") as f:
    f.write(f"[{datetime.now()}] Input: {text} | MD5: {md5} | SHA1: {sha1} | SHA256: {sha256} | SHA512: {sha512}\n")

input("\nPress Enter to return to main menu...")
os.system("kirahash")
