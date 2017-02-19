#
# Makefile for Moto E
#

PORT_PRODUCT = condor_global

## The original zip file, MUST be specified by each product
local-zip-file     := stockrom.zip

# The output zip file of MIUI rom, the default is porting_miui.zip if not specified
local-out-zip-file := MIUI8_Condor.zip

# The location for local-ota to save target-file
local-previous-target-dir :=

# All apps from original ZIP, but has smali files chanded
local-modified-apps :=

local-modified-jars := org.cyanogenmod.platform

# All apks from MIUI
local-miui-removed-apps := Browser BugReport Email FM GameCenter MiuiCamera MiuiCompass MiuiScanner MiGameCenterSDKService MiLivetalk Mipay MiuiVideo MiuiVoip Music QuickSearchBox SogouInput SystemAdSolution VoiceAssist WebViewGoogle XiaomiVip XMPass

local-miui-modified-apps := ContactsProvider InCallUI MiuiSystemUI SecurityCenter TeleService 

# Config density for co-developers to use the aaps with HDPI or XHDPI resource,
# Default configrations are HDPI for ics branch and XHDPI for jellybean branch
local-density := XHDPI

# All apps need to be removed from original ZIP file
local-remove-apps   := 

include phoneapps.mk

# The certificate for release version
local-certificate-dir := security

local-target-bit := 32

# To include the local targets before and after zip the final ZIP file, 
# and the local-targets should:
# (1) be defined after including porting.mk if using any global variable(see porting.mk)
# (2) the name should be leaded with local- to prevent any conflict with global targets
local-pre-zip := local-pre-zip-misc
local-after-zip:= local-put-to-phone

# The local targets after the zip file is generated, could include 'zip2sd' to 
# deliver the zip file to phone, or to customize other actions

include $(PORT_BUILD)/porting.mk

# To define any local-target
#updater := $(ZIP_DIR)/META-INF/com/google/android/updater-script
#pre_install_data_packages := $(TMP_DIR)/pre_install_apk_pkgname.txt
local-pre-zip-misc:
	$(TOOLS_DIR)/post_process_props.py out/ZIP/system/build.prop other/build.prop
	@echo goodbye! miui prebuilt binaries!
	$(hide) rm -rf $(ZIP_DIR)/system/bin/app_process32_vendor
	$(hide) cp -rf stockrom/system/bin/app_process32 $(ZIP_DIR)/system/bin/app_process32
	@echo remove unnecessary libs!
	$(hide) rm -rf $(ZIP_DIR)/system/lib64
	$(hide) rm -rf $(ZIP_DIR)/system/lib/libDecRes_sdk.so
	$(hide) rm -rf $(ZIP_DIR)/system/lib/libjni_eglfence.so
	$(hide) rm -rf $(ZIP_DIR)/system/lib/libjni_filtershow_filters.so
	$(hide) rm -rf $(ZIP_DIR)/system/lib/libjni_jpegstream.so
	$(hide) rm -rf $(ZIP_DIR)/system/lib/libjni_terminal.so
	$(hide) rm -rf $(ZIP_DIR)/system/lib/librsjni.so
	$(hide) rm -rf $(ZIP_DIR)/system/lib/libminivenus.so
	$(hide) rm -rf $(ZIP_DIR)/system/lib/libmresearch.so
	$(hide) rm -rf $(ZIP_DIR)/system/lib/libsecurities_sdk.so
	$(hide) rm -rf $(ZIP_DIR)/system/lib/libwebp.so
	$(hide) rm -rf $(ZIP_DIR)/system/lib/libweibosdkcore_sogou.so
	$(hide) rm -rf $(ZIP_DIR)/system/lib/libxmpass_sdk_patcher.so
	$(hide) rm -rf $(ZIP_DIR)/system/lib/xmpass_libweibosdkcore.so
	@echo remove unnecessary files!
	$(hide) rm -rf $(ZIP_DIR)/data/miui/app/*
	$(hide) rm -rf $(ZIP_DIR)/data/miui/prebuilts
	$(hide) rm -rf $(ZIP_DIR)/data/miui/videoplugins
	$(hide) rm -rf $(ZIP_DIR)/data/miui/yellowpage
	$(hide) rm -rf $(ZIP_DIR)/data/miui/cts.prop
	$(hide) rm -rf $(ZIP_DIR)/data/miui/resolves_miui.conf
	$(hide) rm -rf $(ZIP_DIR)/system/recovery-from-boot.p
	$(hide) rm -rf $(ZIP_DIR)/system/etc/CHANGELOG-CM.txt
	$(hide) rm -rf $(ZIP_DIR)/system/media/audio/*
	@echo copying files!
	$(hide) cp -rf other/system $(ZIP_DIR)/
	$(hide) cp -rf other/noncustomized $(ZIP_DIR)/data/miui/app
	$(hide) cp -rf $(PORT_ROOT)/miui/data/miui/app/customized/ota-miui-MiGalleryLockscreen $(ZIP_DIR)/data/miui/app/noncustomized
	$(hide) cp -rf $(PORT_ROOT)/miui/system/app/$(local-density)/MiuiCompass $(ZIP_DIR)/data/miui/app/noncustomized
	$(hide) cp -rf $(PORT_ROOT)/miui/system/app/$(local-density)/MiuiScanner $(ZIP_DIR)/data/miui/app/noncustomized
	$(hide) cp -rf $(PORT_ROOT)/miui/system/priv-app/$(local-density)/Browser $(ZIP_DIR)/data/miui/app/noncustomized
	$(hide) cp -rf $(PORT_ROOT)/miui/system/priv-app/$(local-density)/Music $(ZIP_DIR)/data/miui/app/noncustomized
	@echo use default sounds miui!
	$(hide) cp -rf $(PORT_ROOT)/miui/system/media/$(local-density)/audio/* $(ZIP_DIR)/system/media/audio
	$(hide) rm -rf $(ZIP_DIR)/system/media/audio/create_symlink_for_audio-timestamp
	@echo use roboto fonts!
	$(hide) cp -rf stockrom/system/fonts/Roboto-Bold.ttf $(ZIP_DIR)/system/fonts/Miui-Bold.ttf
	$(hide) cp -rf stockrom/system/fonts/Roboto-Regular.ttf $(ZIP_DIR)/system/fonts/Miui-Regular.ttf
