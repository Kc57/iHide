FINALPACKAGE=1
TARGET := iphone:clang:latest:7.0
INSTALL_TARGET_PROCESSES = SpringBoard


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = ihide

ihide_FILES = Tweak.x src/utility.c
ihide_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += ihideprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
