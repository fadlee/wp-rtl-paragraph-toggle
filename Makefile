# Makefile for RTL Paragraph Toggle plugin

PLUGIN_NAME = rtl-paragraph-toggle
VERSION = 1.0.0

.PHONY: build zip clean

build:
	@echo "Building $(PLUGIN_NAME) plugin..."
	@chmod +x build-plugin-advanced.sh
	@./build-plugin-advanced.sh

zip:
	@echo "Creating zip package..."
	@./build-plugin-advanced.sh

clean:
	@echo "Cleaning build directory..."
	@rm -rf dist/

install:
	@echo "Installing dependencies (if any)..."
	@echo "No dependencies to install."

help:
	@echo "Available commands:"
	@echo "  make build    - Build the plugin package"
	@echo "  make zip      - Create zip package (same as build)"
	@echo "  make clean    - Remove build artifacts"
	@echo "  make install  - Install dependencies (if any)"
	@echo "  make help     - Show this help message"