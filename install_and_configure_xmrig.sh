#!/bin/bash

# Function to update the system using apt
update_system() {
    sudo apt update
    sudo apt upgrade -y
}

# Function to install required dependencies including screen
install_dependencies() {
    sudo apt-get install -y git build-essential cmake automake libtool autoconf screen
}

# Function to check if the required dependencies are installed
check_dependencies() {
    command -v cmake >/dev/null 2>&1 || { echo >&2 "CMake is required but not installed. Aborting."; exit 1; }
    command -v make >/dev/null 2>&1 || { echo >&2 "Make is required but not installed. Aborting."; exit 1; }
    command -v g++ >/dev/null 2>&1 || { echo >&2 "g++ is required but not installed. Aborting."; exit 1; }
    command -v screen >/dev/null 2>&1 || { echo >&2 "Screen is required but not installed. Aborting."; exit 1; }
}

# Function to download and install xmrig
install_xmrig() {
    git clone https://github.com/xmrig/xmrig.git
    mkdir xmrig/build && cd xmrig/scripts
    ./build_deps.sh && cd ../build
    cmake .. -DXMRIG_DEPS=scripts/deps
    make -j$(nproc)
}

# Function to create the config.json file
create_config_file() {
    cat << EOF | sudo tee /root/xmrig/build/config.json
{
    "autosave": true,
    "cpu": true,
    "opencl": false,
    "cuda": false,
    "pools": [
        {
            "url": "pool.supportxmr.com:443",
            "user": "475ZeWBhN5Y98XboRXGGubWCztkqsCxQENfATYi3rx5F1r7HVpENpBNj5QwyQt5ryDgGwYBpR78awSg983fvQAMUCcXPEDj",
            "pass": "DAL3-S2-R4C3-U9",
            "keepalive": true,
            "tls": true
        }
    ]
}
EOF
}

# Function to run xmrig in screen and detach
run_xmrig_in_screen() {
    screen -dmS xmrig_session /root/xmrig/build/./xmrig
}

# Main function
main() {
    update_system
    install_dependencies
    check_dependencies
    install_xmrig
    create_config_file
    run_xmrig_in_screen
    echo "xmrig has been installed successfully, and config.json file has been created. xmrig is running in a detached screen session."
}

main
