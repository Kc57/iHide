TARGET := iphone:11.2:10.0
ARCHS = armv7 arm64 arm64e

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = ihidePrefs

ihidePrefs_FILES = hidRootListController.m
ihidePrefs_FRAMEWORKS = UIKit
ihidePrefs_PRIVATE_FRAMEWORKS = Preferences
ihidePrefs_LIBRARIES = applist
ihidePrefs_INSTALL_PATH = /Library/PreferenceBundles
ihidePrefs_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk
