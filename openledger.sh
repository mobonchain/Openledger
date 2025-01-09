#!/bin/bash

GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Logging Function
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1"
}

# Error Handling Function
error_exit() {
    log "ERROR: $1"
    exit 1
}

# Validate Root Access
if [[ $EUID -ne 0 ]]; then
   error_exit "This script must be run as root or with sudo"
fi

# Advanced Firewall Configuration
log "Configuring Firewall"
# Disable and reset UFW first to prevent conflicts
ufw disable   
ufw reset -y  
ufw default deny incoming  
ufw default allow outgoing  
ufw allow ssh  
ufw allow 3389/tcp  # RDP Port  
echo "y" | ufw enable || error_exit "Failed to enable firewall"

# Start logging
log "Starting Docker and XRDP Installation Script"

# Update system packages with error checking
log "Updating system packages"
apt update || error_exit "Failed to update packages"
apt upgrade -y || error_exit "Failed to upgrade packages"

# Install required dependencies
log "Installing required dependencies"
apt install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common \
    xfce4 \
    xfce4-goodies \
    gdebi \
    wget \
    unzip \
    || error_exit "Failed to install dependencies"

# Docker Installation
log "Adding Docker GPG key"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

log "Adding Docker repository"
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

log "Updating package index"
apt update || error_exit "Failed to update package index"

log "Installing Docker"
apt install -y docker-ce docker-ce-cli containerd.io || error_exit "Docker installation failed"

# XRDP Configuration
log "Installing XRDP"
apt install -y xrdp || error_exit "XRDP installation failed"

# Configure XRDP for Xfce
echo "xfce4-session" > /root/.xsession

# Enable and start XRDP service
log "Enabling and starting XRDP service"
systemctl enable xrdp
systemctl restart xrdp || error_exit "Failed to start XRDP service"

# OpenLedger Node Installation Function
install_openledger_node() {
    # Change to home directory
    cd ~

    # Log download attempt
    log "Downloading OpenLedger Node Package"
    wget https://cdn.openledger.xyz/openledger-node-1.0.0-linux.zip || error_exit "Failed to download OpenLedger Node package"

    # Log extraction
    log "Extracting OpenLedger Node Package"
    unzip openledger-node-1.0.0-linux.zip || error_exit "Failed to extract OpenLedger Node package"

    # Find the .deb file
    DEB_FILE=$(find . -name "*.deb" | head -n 1)
    
    if [ -z "$DEB_FILE" ]; then
        error_exit "No .deb package found in the extracted files"
    fi

    # Log installation of .deb package
    log "Installing OpenLedger Node .deb Package"
    dpkg -i "$DEB_FILE" || error_exit "Failed to install OpenLedger Node package"

    # Ensure all dependencies are met
    log "Fixing any potential dependency issues"
    apt-get install -f -y || error_exit "Failed to resolve dependencies"

    # Log successful installation
    log "OpenLedger Node Package Installed Successfully"
}

# Get IP Address
IP_ADDRESS=$(hostname -I | awk '{print $1}')

# Final success log
log "Installation Complete!"
echo -e "${CYAN}===== RDP CONNECTION INSTRUCTIONS =====${NC}"
echo -e "${GREEN}1. Login RDP:${NC}"
echo -e "   - IP: ${YELLOW}$IP_ADDRESS${NC}"
echo -e "   - Username: ${YELLOW}root${NC}"
echo -e "   - Password: ${YELLOW}Your VPS Root Password${NC}"
echo ""
echo -e "${GREEN}2. To connect via RDP, follow these steps:${NC}"
echo -e "   ${CYAN}a. On Windows:${NC}"
echo -e "      - Open 'Remote Desktop Connection' (Search for 'mstsc' in the Start menu)."
echo -e "      - In the 'Computer' field, enter the IP address: ${YELLOW}$IP_ADDRESS${NC}"
echo -e "      - Click 'Connect' and enter the username (${YELLOW}root${NC}) and password when prompted."
echo ""
echo -e "   ${CYAN}b. On macOS:${NC}"
echo -e "      - Download and install the 'Microsoft Remote Desktop' app from the Mac App Store."
echo -e "      - Open the app and click 'Add Desktop'."
echo -e "      - Enter the IP address: ${YELLOW}$IP_ADDRESS${NC} and click 'Add'."
echo -e "      - Double-click the new entry and enter the username (${YELLOW}root${NC}) and password when prompted."
echo -e "${CYAN}===== END OF INSTRUCTIONS =====${NC}"


