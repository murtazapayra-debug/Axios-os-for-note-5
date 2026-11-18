#
# SM-N920C product wrapper for the shared Exynos 7420 Note 5 platform.
# Keep this separate from the SM-N920I (nobleltedv) target.
#
include device/samsung/noblelte/BoardConfig.mk

TARGET_OTA_ASSERT_DEVICE := noblelte,nobleltejv,nobleltec
AB_OTA_UPDATER := false
TARGET_PRESERVE_EXTERNAL_RECOVERY := true
KERNEL_CC := CC="$(KERNEL_CC_WRAPPER) clang"
$(call soong_config_set,samsungVars,target_specific_header_path,device/samsung/universal7420-common/include)

BOARD_VENDOR_SEPOLICY_DIRS += device/samsung/nobleltespr/sepolicy/vendor
# These policy rules are shared Note 5 platform rules, not N920I-only hardware.
BOARD_VENDOR_SEPOLICY_DIRS += device/samsung/nobleltedv/sepolicy/vendor
SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += device/samsung/nobleltedv/sepolicy/private

PRODUCT_SOONG_NAMESPACES += device/samsung/nobleltespr
PRODUCT_SOONG_NAMESPACES += hardware/broadcom/libbt
$(call soong_config_set,brcm_libbt,custom_bt_config,//device/samsung/nobleltespr:note5_bluetooth_vendor_config)
$(call soong_config_set,brcm_libbt,bdroid_buildcfg_include_dir,device/samsung/noblelte/bluetooth)

DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE := $(filter-out vendor/lineage/config/device_framework_matrix.xml,$(DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE))
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE += device/samsung/nobleltespr/framework_compatibility_matrix.xml
TARGET_RELEASETOOLS_EXTENSIONS := device/samsung/nobleltespr/releasetools

# N920C is configured as single-SIM; expose only the primary radio slot.
DEVICE_MANIFEST_FILE += device/samsung/nobleltec/modem/radio-manifest.xml
