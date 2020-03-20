#/bin/bash
#=================================================
# Description: OpenWrt DIY script
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
# 复制自p3terx
# https://github.com/destan19/GDOCK/blob/master/diy.sh
# 替换lean首页文件，添加天气代码(by:冷淡)
# 参考https://github.com/openwrtcompileshell/OpenwrtCompileScript
#=================================================
# Modify default IP
sed -i 's/192.168.1.1/192.168.11.1/g' package/base-files/files/bin/config_generate

# Modify default hostname
sed -i 's/OpenWrt/noodles/g' package/base-files/files/bin/config_generate

# Modify default WiFi SSID
# sed -i 's/OpenWrt/noodles/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

# Modify the version number
sed -i 's/OpenWrt/noodles build $(date "+%Y.%m.%d") @ OpenWrt/g' package/lean/default-settings/files/zzz-default-settings

# Modify default theme
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile
#sed -i 's/config internal themes/config internal themes\n    option Argon  \"\/luci-static\/argon\"/g' feeds/luci/modules/luci-base/root/etc/config/luci

# 修改时区
# sed -i "s/'UTC'/'CST-8'\n        set system.@system[-1].zonename='Asia\/Shanghai'/g" package/base-files/files/bin/config_generate

# 删除旧版argon,链接新版
#echo '删除旧版argon,链接新版'
#rm -rf ./package/lean/luci-theme-argon
#ln -s ../../../luci-theme-argon ./package/lean/

# Add kernel build user
[ -z $(grep "CONFIG_KERNEL_BUILD_USER=" .config) ] &&
    echo 'CONFIG_KERNEL_BUILD_USER="noodles"' >>.config ||
    sed -i 's@\(CONFIG_KERNEL_BUILD_USER=\).*@\1$"noodles"@' .config

# Add kernel build domain
[ -z $(grep "CONFIG_KERNEL_BUILD_DOMAIN=" .config) ] &&
    echo 'CONFIG_KERNEL_BUILD_DOMAIN="GitHub Actions"' >>.config ||
    sed -i 's@\(CONFIG_KERNEL_BUILD_DOMAIN=\).*@\1$"GitHub Actions"@' .config

# 替换index
# echo ''
#rm -rf feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_status/index.htm
#cp noodlesindex/index.htm feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_status/index.htm

# 替换x86_index
#rm -rf package/lean/autocore/files/index.htm
#cp noodlesindex/x86_index.htm package/lean/autocore/files/index.htm

# 添加天气预报翻译 
#sed -i '$a \       ' feeds/luci/modules/luci-base/po/zh-cn/base.po
#sed -i '$a #天气预报' feeds/luci/modules/luci-base/po/zh-cn/base.po
#sed -i '$a msgid "Weather"' feeds/luci/modules/luci-base/po/zh-cn/base.po
#sed -i '$a msgstr "天气"' feeds/luci/modules/luci-base/po/zh-cn/base.po
#sed -i '$a \       ' feeds/luci/modules/luci-base/po/zh-cn/base.po
#sed -i '$a msgid "Local Weather"' feeds/luci/modules/luci-base/po/zh-cn/base.po
#sed -i '$a msgstr "本地天气"' feeds/luci/modules/luci-base/po/zh-cn/base.po