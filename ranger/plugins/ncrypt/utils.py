import zipfile
import os
from Crypto.Cipher import AES
from ranger.api.commands import Command
import os
import subprocess

def compress_folder(folder_path, output_zip_path):
    with zipfile.ZipFile(output_zip_path, 'w', zipfile.ZIP_DEFLATED) as zipf:
        for root, dirs, files in os.walk(folder_path):
            for file in files:
                file_path = os.path.join(root, file)
                arcname = os.path.relpath(file_path, folder_path)
                zipf.write(file_path, arcname)

def extract_folder(zip_path, output_folder_path):
    with zipfile.ZipFile(zip_path, 'r') as zipf:
        zipf.extractall(output_folder_path)

def encrypt_file(in_file, key):
    iv = key[:16]
    with open(in_file, 'rb') as f:
        plaintext = f.read()
    cipher = AES.new(key, AES.MODE_CFB, iv)
    ciphertext = cipher.encrypt(plaintext)
    out_file = f"{in_file}.enc"
    with open(out_file, 'wb') as f:
        f.write(ciphertext)


def decrypt_file(in_file, key):
    iv = key[:16]
    with open(in_file, 'rb') as f:
        ciphertext = f.read()
    cipher = AES.new(key, AES.MODE_CFB, iv)
    plaintext = cipher.decrypt(ciphertext)
    out_file = in_file.split(".enc")[0]
    with open(out_file, 'wb') as f:
        f.write(plaintext)