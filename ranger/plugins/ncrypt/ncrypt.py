from ranger.api.commands import Command
import os
from Crypto.Cipher import AES
import subprocess
import zipfile

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

# Shred command. Usage:  :shred
class shred(Command):
    """
    :shred

    Securely delete the selected file(s) using shred after a confirmation prompt.
    """
    def execute(self):
        def shred_file(ans):
            if ans in ('y', 'Y', 'yes', 'Yes', 'YES'):
                for file in self.fm.thistab.get_selection():
                    subprocess.call(['shred', '-f', '-u', '-z', file.path])
                    self.fm.notify('Shredding file: ' + os.path.basename(file.path))

        # Confirmation prompt
        marked_files = [f.path for f in self.fm.thistab.get_selection()]
        file_list = ', '.join([os.path.basename(f) for f in marked_files])
        prompt = "Do you want to shred the following file? (y/n)\n%s\n: " % file_list
        self.fm.ui.console.ask(prompt, shred_file)


# File encryption command. Usage: encrypt <key>
class encrypt(Command):
    def execute(self):

        # Check if correct number of arguments is passed
        if len(self.args) != 2:
            self.fm.notify("Invalid args.")
            return

        key = str.encode(self.args[1])

        paths = self.fm.thistab.get_selection()
        for path in paths:

            if os.path.isdir(str(path)):

                # inform user that compressing has begun
                self.fm.notify(f'Compressing {str(path)} ..')

                # compress dir
                compress_folder(str(path), str(path) + ".zip")

                # inform user that encryption has begun
                self.fm.notify(f'Encrypting {str(path)} ..')

                # encrypt it
                encrypt_file(str(path) + ".zip", key)

                # inform user that encryption is completed
                self.fm.notify(f'{str(path)} has been compressed and encrypted.')

            else:

                # inform user that encryption has begun
                self.fm.notify(f"Encrypting {str(path)} ..")

                # encrypt it
                encrypt_file(str(path), key)

                # inform user that encryption is completed
                self.fm.notify(f"{path} has been encrypted.")


# File decryption command. Usage: encrypt <key>
class decrypt(Command):
    def execute(self):

        # Check if correct number of arguments is passed
        if len(self.args) != 2:
            self.fm.notify("Invalid args.")
            return

        key = str.encode(self.args[1])

        # Iterate over selected files and encrypt them
        for file in self.fm.thistab.get_selection():
            
            # inform user that decrypting has begun
            self.fm.notify("Decrypting ..")

            # decrypt it
            decrypt_file(str(file), key)

            # inform user that decryption is completed
            self.fm.notify(f"{file} has been decrypted.")