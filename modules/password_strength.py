#!/usr/bin/env python3
import os
import re
from datetime import datetime
from math import log2
import random

os.system("clear")
os.system("toilet -f pagga 'STRENGTH CHECK' | lolcat")
print("\033[1;36m🔐 Welcome to the Password Strength Analyzer!\033[0m\n")

password = input("\033[1;33mEnter the password to check:\033[0m ").strip()

length = len(password)
has_upper = bool(re.search(r"[A-Z]", password))
has_lower = bool(re.search(r"[a-z]", password))
has_digit = bool(re.search(r"[0-9]", password))
has_special = bool(re.search(r"[!@#$%^&*()_+{}\[\]:;<>,.?~\\/-]", password))

# Charset & entropy
charset_size = 0
if has_upper: charset_size += 26
if has_lower: charset_size += 26
if has_digit: charset_size += 10
if has_special: charset_size += 32
entropy = round(length * log2(charset_size)) if charset_size > 0 else 0

# Crack time estimation
def crack_time(entropy_bits):
    if entropy_bits < 30:
        return "\033[1;31m🔴 Instantly crackable\033[0m"
    elif entropy_bits < 50:
        return "\033[1;33m🟠 Crackable within minutes or hours\033[0m"
    elif entropy_bits < 70:
        return "\033[1;35m🟡 Days to weeks\033[0m"
    else:
        return "\033[1;32m🟢 Very strong (years+ to crack)\033[0m"

# Dictionary match
weak_words = ['password', '123456', 'qwerty', 'letmein', 'welcome', 'admin', 'login']
is_common = any(word in password.lower() for word in weak_words)

# Feedback
print("\n\033[1;34m🔍 Analysis Report:\033[0m")
print(f"🔢 Length: \033[1m{length}\033[0m")
print(f"🔠 Uppercase: {'✅' if has_upper else '❌'}")
print(f"🔡 Lowercase: {'✅' if has_lower else '❌'}")
print(f"🔢 Digits: {'✅' if has_digit else '❌'}")
print(f"🔣 Special Characters: {'✅' if has_special else '❌'}")
print(f"📛 Common Word Usage: {'❌ Weak' if is_common else '✅ Not common'}")
print(f"🔐 Estimated Entropy: \033[1m{entropy} bits\033[0m")
print(f"⏱️ Crack Time Estimate: {crack_time(entropy)}")

# Suggestion
if length < 12 or not all([has_upper, has_lower, has_digit, has_special]):
    suggestions = ["$", "#", "@", "!", "9", "7", random.choice(["2025", "Xx", "Secure"])]
    suffix = "".join(random.sample(suggestions, 3))
    recommended = password.capitalize() + suffix
    print(f"\n\033[1;33m💡 Suggestion:\033[0m Consider using at least 12 characters with uppercase, lowercase, numbers, and symbols.")
    print(f"🔏 Example strong password: \033[1;32m{recommended}\033[0m")

# Log result
log_folder = os.path.expanduser("~/Desktop/kirahash_logs")
os.makedirs(log_folder, exist_ok=True)
with open(f"{log_folder}/password_strength_log.txt", "a") as f:
    f.write(f"[{datetime.now()}] PASSWORD: {password} | Entropy: {entropy} bits | Strength: {crack_time(entropy)}\n")

input("\n\033[1;36mPress Enter to return to main menu...\033[0m")
os.system("kirahash")
