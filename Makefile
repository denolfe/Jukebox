PROJECT := Jukebox.xcodeproj
SCHEME := Jukebox
CONFIG ?= Release
APP_NAME := Jukebox.app
INSTALL_DIR := /Applications

BUILD_FLAGS := -project $(PROJECT) -scheme $(SCHEME) -configuration $(CONFIG) \
	CODE_SIGNING_ALLOWED=NO CODE_SIGNING_REQUIRED=NO CODE_SIGN_IDENTITY=""

BUILT_APP := $(shell xcodebuild $(BUILD_FLAGS) -showBuildSettings 2>/dev/null | awk '/ BUILT_PRODUCTS_DIR =/ {print $$3}')/$(APP_NAME)

.PHONY: build install clean debug debug-run run

build:
	xcodebuild $(BUILD_FLAGS) build

debug:
	$(MAKE) build CONFIG=Debug

install: build
	@echo "Installing $(BUILT_APP) -> $(INSTALL_DIR)/"
	rm -rf $(INSTALL_DIR)/$(APP_NAME)
	cp -R $(BUILT_APP) $(INSTALL_DIR)/

run: install
	open $(INSTALL_DIR)/$(APP_NAME)

debug-run:
	$(MAKE) run CONFIG=Debug

clean:
	xcodebuild $(BUILD_FLAGS) clean
