#!/bin/bash

# Enhanced build script with error handling and progress reporting
# for AWS IoT Greengrass Device Defender Custom Metrics

set -e  # Exit immediately if a command exits with a non-zero status

# Define color codes for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to display progress messages
log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

# Function to display warning messages
log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Function to display error messages
log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check prerequisites
log_info "Checking prerequisites..."

if ! command_exists git; then
    log_error "Git is not installed. Please install git and try again."
    exit 1
fi

# Create a clean build directory
COMPONENT_DIR="com.awsiotblog.DeviceDefenderCustom"
if [ -d "$COMPONENT_DIR" ]; then
    log_warning "Directory $COMPONENT_DIR already exists. Removing it..."
    rm -rf "$COMPONENT_DIR"
fi

# Clone the main repository
log_info "Cloning aws-greengrass-device-defender repository..."
if ! git clone https://github.com/aws-greengrass/aws-greengrass-device-defender.git "$COMPONENT_DIR"; then
    log_error "Failed to clone aws-greengrass-device-defender repository."
    exit 1
fi

# Navigate to the component directory
cd "$COMPONENT_DIR" || { log_error "Failed to navigate to $COMPONENT_DIR"; exit 1; }

# Checkout specific commit
log_info "Checking out specific commit..."
if ! git checkout a804600917a08ce3ada5eab0744bb1f8c97857c8; then
    log_error "Failed to checkout specific commit."
    exit 1
fi

# Create SDK directory if it doesn't exist
SDK_DIR="greengrass_defender_agent/AWSIoTDeviceDefenderAgentSDK"
mkdir -p "$(dirname "$SDK_DIR")" || { log_error "Failed to create directory structure"; exit 1; }

# Clone the SDK repository
log_info "Cloning aws-iot-device-defender-agent-sdk-python repository..."
if ! git clone https://github.com/aws-samples/aws-iot-device-defender-agent-sdk-python.git "$SDK_DIR"; then
    log_error "Failed to clone aws-iot-device-defender-agent-sdk-python repository."
    exit 1
fi

# Navigate to the SDK directory
cd "$SDK_DIR" || { log_error "Failed to navigate to $SDK_DIR"; exit 1; }

# Checkout specific commit
log_info "Checking out specific SDK commit..."
if ! git checkout a3d27c51311e12625bd0b774e8b730ead3bc515d; then
    log_error "Failed to checkout specific SDK commit."
    exit 1
fi

# Apply SDK patch
log_info "Applying SDK patch..."
if ! git apply ../../../patches/patches_aws-iot-device-defender-agent-sdk-python.patch; then
    log_error "Failed to apply SDK patch."
    exit 1
fi

# Navigate back to the component directory
cd ../.. || { log_error "Failed to navigate back to component directory"; exit 1; }

# Apply main patch
log_info "Applying main component patch..."
if ! git apply ../patches/patches_aws-greengrass-device-defender.patch; then
    log_error "Failed to apply main component patch."
    exit 1
fi

log_info "Build completed successfully!"
log_info "The custom Device Defender component is ready in the $COMPONENT_DIR directory."