#!/bin/bash

set -e

clear

RED='\e[1;31m'
GREEN='\e[1;32m'
YELLOW='\e[1;33m'
BLUE='\e[1;34m'
CYAN='\e[1;36m'
WHITE='\e[1;37m'
ORANGE='\e[1;93m'
NC='\e[0m'

if [[ $EUID -ne 0 ]]; then
   echo -e "${RED}This script must be run as root"
   exit 1
fi

COLOR_NUM=$((RANDOM % 7))
# Assign a color variable based on the random number
case $COLOR_NUM in
    0) COLOR=$RED;;
    1) COLOR=$GREEN;;
    2) COLOR=$YELLOW;;
    3) COLOR=$BLUE;;
    4) COLOR=$CYAN;;
    5) COLOR=$ORANGE;;
    *) COLOR=$WHITE;;
esac

echo -e "${COLOR}"
echo ""
echo "   ▄█    █▄       ▄████████  ▄████████    ▄█   ▄█▄  ▄█  ███▄▄▄▄      ▄██████▄           ███      ▄██████▄   ▄██████▄   ▄█       ";
echo "  ███    ███     ███    ███ ███    ███   ███ ▄███▀ ███  ███▀▀▀██▄   ███    ███      ▀█████████▄ ███    ███ ███    ███ ███       ";
echo "  ███    ███     ███    ███ ███    █▀    ███▐██▀   ███▌ ███   ███   ███    █▀          ▀███▀▀██ ███    ███ ███    ███ ███       ";
echo " ▄███▄▄▄▄███▄▄   ███    ███ ███         ▄█████▀    ███▌ ███   ███  ▄███                 ███   ▀ ███    ███ ███    ███ ███       ";
echo "▀▀███▀▀▀▀███▀  ▀███████████ ███        ▀▀█████▄    ███▌ ███   ███ ▀▀███ ████▄           ███     ███    ███ ███    ███ ███       ";
echo "  ███    ███     ███    ███ ███    █▄    ███▐██▄   ███  ███   ███   ███    ███          ███     ███    ███ ███    ███ ███       ";
echo "  ███    ███     ███    ███ ███    ███   ███ ▀███▄ ███  ███   ███   ███    ███          ███     ███    ███ ███    ███ ███▌    ▄ ";
echo "  ███    █▀      ███    █▀  ████████▀    ███   ▀█▀ █▀    ▀█   █▀    ████████▀          ▄████▀    ▀██████▀   ▀██████▀  █████▄▄██ ";
echo "                                         ▀                                                                            ▀         ";

echo -e "${BLUE}                                    https://github.com/Z4nzu/hackingtool ${NC}"
echo -e "${GREEN}                                   Fedora installation script made by P@p@C0d€ur ${NC}" 
echo -e "${RED}                                     [!] This Tool Must Run As ROOT [!]${NC}\n"

# Define installation directories
install_dir="/usr/share/hackingtool"
bin_dir="/usr/bin"

sudo dnf -y update
sudo dnf -y install python-pip

echo "";
        echo -e "${YELLOW}[*] Checking directories...${NC}"
        if [[ -d "$install_dir" ]]; then
            echo -e -n "${RED}[!] The directory $install_dir already exists. Do you want to replace it? [y/n]: ${NC}"
            read input
            if [[ $input == "y" ]] || [[ $input == "Y" ]]; then
                echo -e "${YELLOW}[*]Removing existing module.. ${NC}"
                sudo rm -rf "$install_dir"
            else
                echo -e "${RED}[✘]Installation Not Required[✘] ${NC}"
                exit
            fi
        fi


	echo "";
        echo -e "${YELLOW}[✔] Downloading hackingtool...${NC}"
        if sudo git clone https://github.com/Z4nzu/hackingtool.git $install_dir; then
            # Install virtual environment
            echo -e "${YELLOW}[*] Installing Virtual Environment...${NC}"
	fi
            echo "";
            # Create a virtual environment for the tool
            echo -e "${YELLOW}[*] Creating virtual environment..."
            sudo python3 -m venv $install_dir/venv
            source $install_dir/venv/bin/activate
            # Install requirements
            echo -e "${GREEN}[✔] Virtual Environment successfully [✔]${NC}";
            echo "";
            echo -e "${YELLOW}[*] Installing requirements...${NC}"
	    pip3 install -r $install_dir/requirements.txt
            sudo dnf -y install figlet 

	    # Create a shell script to launch the tool
            echo -e "${YELLOW}[*] Creating a shell script to launch the tool..."
            echo '#!/bin/bash' > $install_dir/hackingtool.sh
            echo "source $install_dir/venv/bin/activate" >> $install_dir/hackingtool.sh
            echo "python3 $install_dir/hackingtool.py \$@" >> $install_dir/hackingtool.sh
            chmod +x $install_dir/hackingtool.sh
            sudo mv $install_dir/hackingtool.sh $bin_dir/hackingtool
            echo -e "${GREEN}[✔] Script created successfully [✔]"

	if [ -d $install_dir ]; then
        	echo "";
        	echo -e "${GREEN}[✔] Successfully Installed [✔]";
        	echo "";
        	echo "";
        	echo -e  "${ORANGE}[+]+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++[+]"
        	echo     "[+]                                                             [+]"
        	echo -e  "${ORANGE}[+]     ✔✔✔ Now Just Type In Terminal (hackingtool) ✔✔✔      [+]"
        	echo     "[+]                                                             [+]"
        	echo -e  "${ORANGE}[+]+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++[+]"
    	else
        	echo -e "${RED}[✘] Installation Failed !!! [✘]";
        	exit 1
        fi
