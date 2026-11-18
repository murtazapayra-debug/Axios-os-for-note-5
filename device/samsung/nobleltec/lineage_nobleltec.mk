#
# Copyright (C) 2026
# SPDX-License-Identifier: Apache-2.0
#
# SM-N920C: separate product identity; shared Exynos 7420 device and modem stack.
# The device codename here is an internal build target (nobleltec), while the
# installer accepts the physical N920C codenames noblelte/nobleltejv.

PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,device/samsung/nobleltespr/proprietary/vendor/etc/nxp,$(TARGET_COPY_OUT_VENDOR)/etc/nxp)

PRODUCT_COPY_FILES += \
    device/samsung/nobleltedv/performance/powerhint.json:$(TARGET_COPY_OUT_VENDOR)/etc/powerhint.json \
    device/samsung/nobleltedv/performance/init.nobleltedv-power.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.nobleltedv-power.rc

$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)
$(call inherit-product, device/samsung/noblelte/device.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

PRODUCT_NAME := lineage_nobleltec
PRODUCT_DEVICE := nobleltec
PRODUCT_MODEL := SM-N920C
PRODUCT_BRAND := samsung
PRODUCT_MANUFACTURER := samsung
PRODUCT_GMS_CLIENTID_BASE := android-samsung
PRODUCT_SHIPPING_API_LEVEL := 22

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME=nobleltejv \
    TARGET_DEVICE=noblelte \
    PRIVATE_BUILD_DESC="nobleltejv-user 7.0 NRD90M N920CXXS5CRH3 release-keys"
BUILD_FINGERPRINT := "samsung/nobleltejv/noblelte:7.0/NRD90M/N920CXXS5CRH3:user/release-keys"

PRODUCT_COPY_FILES += \
    device/samsung/nobleltespr/releasetools/note5-resize-system.sh:install/bin/note5-resize-system.sh

PRODUCT_PACKAGES += cbd modemloader libexpat.vendor
PRODUCT_COPY_FILES += \
    device/samsung/nobleltedv/modem/init.nobleltedv-baseband.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.nobleltedv-baseband.rc \
    device/samsung/nobleltedv/modem/init.nobleltedv-ril.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.nobleltedv-ril.rc \
    vendor/samsung/universal7420-common/proprietary/vendor/bin/hw/rild:$(TARGET_COPY_OUT_VENDOR)/bin/hw/rild \
    vendor/samsung/universal7420-common/proprietary/vendor/etc/init/init.vendor.rilcommon.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.vendor.rilcommon.rc

PRODUCT_VENDOR_PROPERTIES += \
    ro.vendor.multisim.simslotcount=1 \
    ro.vendor.note5.sim_autodetect=true
PRODUCT_SYSTEM_PROPERTIES += ro.telephony.default_network=9
PRODUCT_SYSTEM_PROPERTIES += ro.arch=exynos7420

PRODUCT_PACKAGES += PhhIms PhhImsTelephonyOverlay PhhImsFrameworkOverlay
PRODUCT_PACKAGES += Iwlan QualifiedNetworksService
PRODUCT_DEXPREOPT_SPEED_APPS += LatinIME
DEVICE_PACKAGE_OVERLAYS := device/samsung/nobleltedv/overlay-wfc $(DEVICE_PACKAGE_OVERLAYS)
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.ipsec_tunnels.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.ipsec_tunnels.xml \
    frameworks/native/data/etc/android.hardware.telephony.ims.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.telephony.ims.xml

PRODUCT_SOURCE_ROOT_DIRS += \
    -hardware/samsung_slsi-linaro/interfaces/ExynosA2DPOffload \
    -hardware/samsung_slsi-linaro/interfaces/a2dp \
    -hardware/samsung/hidl/livedisplay \
    -hardware/samsung/hidl/touch \
    -hardware/samsung/hidl/fastcharge \
    -hardware/samsung/hidl/powershare \
    -hardware/samsung/hidl/vibrator/haptic \
    -device/samsung/universal7420-common/hardware/livedisplay \
    -hardware/samsung_slsi-linaro/exynos/libdisplaycolor/unittest \
    -hardware/samsung_slsi-linaro/exynos/libhdr/unittest \
    -hardware/samsung_slsi-linaro/exynos/ssp

ifneq ($(filter userdebug eng,$(TARGET_BUILD_VARIANT)),)
PRODUCT_SYSTEM_PROPERTIES += ro.note5.legacy_bpf=true
PRODUCT_SYSTEM_PROPERTIES += ro.note5.wfd_disabled=true
DEVICE_PACKAGE_OVERLAYS := device/samsung/nobleltespr/overlay-offline $(DEVICE_PACKAGE_OVERLAYS)
PRODUCT_COPY_FILES += \
    device/samsung/nobleltespr/init.note5-offline.rc:$(TARGET_COPY_OUT_SYSTEM)/etc/init/init.note5-offline.rc
endif

PRODUCT_COPY_FILES += \
    device/samsung/nobleltec/n920c-features.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/note5-n920c-features.xml
PRODUCT_SYSTEM_PROPERTIES += ro.note5.legacy_vti=true
