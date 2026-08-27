#
# Copyright (C) 2022 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Inherit from motorola sm6375-common
$(call inherit-product, device/motorola/sm6375-common/common.mk)

TARGET_SCREEN_DENSITY := 280

# AAPT
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := 280dpi
PRODUCT_AAPT_PREBUILT_DPI := xxxhdpi xxhdpi xhdpi hdpi

# Resource Overlays
PRODUCT_PACKAGES += \
    FrameworksResFogos \
    FrameworksResXT2363-8 \
    NfcOverlayFogos \
    SettingsOverlayXT2363-1 \
    SettingsOverlayXT2363-2 \
    SettingsOverlayXT2363-3 \
    SettingsOverlayXT2363-5 \
    SettingsOverlayXT2363-8 \
    SettingsProviderResFogos \
    SettingsProviderResXT2363-8 \
    SettingsResFogos \
    SystemUIResFogos

# Remove unwanted packages
PRODUCT_PACKAGES += \
    RemovePackages

# Camera
PRODUCT_PACKAGES += \
    libgui_shim_vendor

# Fingerprint
PRODUCT_PACKAGES += \
    android.hardware.biometrics.fingerprint@2.1.vendor \
    com.motorola.hardware.biometric.fingerprint@1.0.vendor

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/idc/uinput-fpc.idc:$(TARGET_COPY_OUT_VENDOR)/usr/idc/uinput-fpc.idc \
    $(LOCAL_PATH)/configs/idc/uinput_nav.idc:$(TARGET_COPY_OUT_VENDOR)/usr/idc/uinput_nav.idc \
    $(LOCAL_PATH)/configs/keylayout/uinput-fpc.kl:$(TARGET_COPY_OUT_VENDOR)/usr/keylayout/uinput-fpc.kl \
    $(LOCAL_PATH)/configs/keylayout/uinput_nav.kl:$(TARGET_COPY_OUT_VENDOR)/usr/keylayout/uinput_nav.kl

# Power
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/power/powerhint-blairpro.json:$(TARGET_COPY_OUT_VENDOR)/etc/powerhint-blairpro.json

# LiveDisplay
$(call soong_config_set_bool,livedisplay_sysfs,enable_ab,true)

# Lineage Health
$(call soong_config_set,lineage_health,charging_control_charging_path,sys/class/power_supply/battery/input_current_limit)
$(call soong_config_set,lineage_health,charging_control_charging_enabled,0)
$(call soong_config_set,lineage_health,charging_control_charging_disabled,1)
$(call soong_config_set_bool,lineage_health,charging_control_supports_bypass,false)
$(call soong_config_set,lineage_health,fast_charge_node,/sys/class/qcom-battery/restrict_chg)
$(call soong_config_set,lineage_health,fast_charge_value_none,1)
$(call soong_config_set,lineage_health,fast_charge_value_fast_charge,0)

# NFC
PRODUCT_PACKAGES += \
    android.hardware.nfc@1.2-service.samsung \
    com.android.nfc_extras \
    Tag

# Virtual A/B
TARGET_IS_VAB := true

# Shipping API
PRODUCT_SHIPPING_API_LEVEL := 34

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Init
PRODUCT_PACKAGES += \
    init.mmi.overlay.rc \
    init.nfc.sec.rc \
    init.oem.fingerprint2.sh

# Inherit from vendor blobs
$(call inherit-product, vendor/motorola/fogos/fogos-vendor.mk)