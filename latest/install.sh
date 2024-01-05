#!/bin/sh

installer_path=$PWD

echo "[+] Checking for required dependencies..."
if command -v git >/dev/null 2>&1 ; then
    echo "[-] Git found!"
else
    echo "[-] Git not found! Aborting..."
    echo "[-] Please install git and try again."
fi

if [ -f ~/.gdbinit ] || [ -h ~/.gdbinit ]; then
    echo "[+] backing up gdbinit file"
    cp ~/.gdbinit ~/.gdbinit.back_up
fi

# download peda and decide whether to overwrite if exists
if [ -d ~/setting/peda ] || [ -h ~/setting/.peda ]; then
    echo "[-] PEDA found"
    read -p "skip download to continue? (enter 'y' or 'n') " skip_peda

    if [ $skip_peda = 'n' ]; then
        rm -rf ~/peda
        git clone https://github.com/longld/peda.git ~/setting/peda
    else
        echo "PEDA skipped"
    fi
else
    echo "[+] Downloading PEDA..."
    git clone https://github.com/longld/peda.git ~/setting/peda
fi

# download peda arm
if [ -d ~/setting/peda-arm ] || [ -h ~/setting/.peda ]; then
    echo "[-] PEDA ARM found"
    read -p "skip download to continue? (enter 'y' or 'n') " skip_peda

    if [ $skip_peda = 'n' ]; then
        rm -rf ~/peda-arm
	git clone https://github.com/alset0326/peda-arm.git
    else
	echo "PEDA ARM skipped"
    fi
else	    
    echo "[+] Downloading PEDA ARM..."
    git clone https://github.com/alset0326/peda-arm.git ~/setting/peda-arm
fi

# download pwndbg
if [ -d ~/setting/pwndbg ] || [ -h ~/setting/.pwndbg ]; then
    echo "[-] Pwndbg found"
    read -p "skip download to continue? (enter 'y' or 'n') " skip_pwndbg

    if [ $skip_pwndbg = 'n' ]; then
        rm -rf ~/setting/pwndbg
        git clone https://github.com/pwndbg/pwndbg.git ~/setting/pwndbg
        sudo cp -r /data/setup.sh /home/user/setting/pwndbg/setup.sh

        cd ~/setting/pwndbg
        
        sudo ./setup.sh
    else
        echo "Pwndbg skipped"
    fi
else
    echo "[+] Downloading Pwndbg..."
    sudo git clone https://github.com/pwndbg/pwndbg.git ~/setting/pwndbg
    sudo cp -r /data/setup.sh /home/user/setting/pwndbg/setup.sh

    sudo cd ~/setting/pwndbg

    sudo ./setup.sh
fi

# download gef
# change
#echo "[+] Downloading GEF..."
rm -rf ~/setting/gef
git clone https://github.com/hugsy/gef.git ~/setting/gef
# sudo wget https://github.com/hugsy/gef/archive/refs/tags/2021.10.zip
# sudo unzip 2021.10.zip


sudo cd $installer_path

echo "[+] Setting .gdbinit..."
sudo cp ~/setting/gdb-peda-pwndbg-gef/gdbinit ~/setting/.gdbinit

{
  echo "[+] Creating files..."
    sudo cp ~/setting/gdb-peda-pwndbg-gef/gdb-peda /usr/bin/gdb-peda &&\
    sudo cp ~/setting/gdb-peda-pwndbg-gef/gdb-peda-arm /usr/bin/gdb-peda-arm &&\
    sudo cp ~/setting/gdb-peda-pwndbg-gef/gdb-peda-intel /usr/bin/gdb-peda-intel &&\
    sudo cp ~/setting/gdb-peda-pwndbg-gef/gdb-pwndbg /usr/bin/gdb-pwndbg &&\
    sudo cp ~/setting/gdb-peda-pwndbg-gef/gdb-gef /usr/bin/gdb-gef
} || {
  echo "[-] Permission denied"
    exit
}

{
  echo "[+] Setting permissions..."
    sudo chmod +x /usr/bin/gdb-*
} || {
  echo "[-] Permission denied"
    exit
}

echo "[+] Done"
