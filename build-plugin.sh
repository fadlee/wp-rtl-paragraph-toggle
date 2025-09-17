#!/bin/bash

# Plugin build script for RTL Paragraph Toggle

echo "Building RTL Paragraph Toggle plugin..."

# Define variables
PLUGIN_NAME="rtl-paragraph-toggle"
BUILD_DIR="dist"
VERSION="1.0.0"

# Remove existing build directory if it exists
if [ -d "$BUILD_DIR" ]; then
  rm -rf "$BUILD_DIR"
fi

# Create new build directory
mkdir -p "$BUILD_DIR/$PLUGIN_NAME"

# Copy plugin files to build directory
echo "Copying plugin files..."
cp -r rtl-paragraph-toggle.php css build "$BUILD_DIR/$PLUGIN_NAME/"

# Create the zip file
echo "Creating zip file..."
cd "$BUILD_DIR"
zip -r "${PLUGIN_NAME}.zip" "$PLUGIN_NAME"

# Move back to project root
cd ..

echo "Plugin packaged successfully!"
echo "Zip file created: $BUILD_DIR/${PLUGIN_NAME}.zip"
echo "Version: $VERSION"