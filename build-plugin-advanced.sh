#!/bin/bash

# Advanced plugin build script for RTL Paragraph Toggle

echo "Building RTL Paragraph Toggle plugin..."

# Define variables
PLUGIN_NAME="rtl-paragraph-toggle"
PLUGIN_FILE="$PLUGIN_NAME.php"
BUILD_DIR="dist"

# Extract version from plugin file
VERSION=$(grep -Ei 'Version:\s*[0-9]+\.[0-9]+\.[0-9]+' "$PLUGIN_FILE" | grep -oE '[0-9]+\.[0-9]+\.[0-9]+')

if [ -z "$VERSION" ]; then
  echo "Error: Could not extract version from $PLUGIN_FILE"
  exit 1
fi

echo "Plugin version: $VERSION"

# Remove existing build directory if it exists
if [ -d "$BUILD_DIR" ]; then
  rm -rf "$BUILD_DIR"
fi

# Create new build directory
mkdir -p "$BUILD_DIR/$PLUGIN_NAME"

# Copy plugin files to build directory
echo "Copying plugin files..."
cp -r "$PLUGIN_FILE" css build "$BUILD_DIR/$PLUGIN_NAME/"

# Create the zip file
echo "Creating zip file..."
cd "$BUILD_DIR"
zip -r "${PLUGIN_NAME}.${VERSION}.zip" "$PLUGIN_NAME"

# Move back to project root
cd ..

echo "Plugin packaged successfully!"
echo "Zip file created: $BUILD_DIR/${PLUGIN_NAME}.${VERSION}.zip"
echo "Version: $VERSION"

# Optional: Create a symlink to the latest version for easy access
cd "$BUILD_DIR"
if [ -f "${PLUGIN_NAME}.zip" ]; then
  rm "${PLUGIN_NAME}.zip"
fi
ln -s "${PLUGIN_NAME}.${VERSION}.zip" "${PLUGIN_NAME}.zip"
cd ..

echo "Latest version symlink created: $BUILD_DIR/${PLUGIN_NAME}.zip"