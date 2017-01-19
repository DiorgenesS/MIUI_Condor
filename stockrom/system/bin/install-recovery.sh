#!/system/bin/sh
if [ -f /system/etc/recovery-transform.sh ]; then
  exec sh /system/etc/recovery-transform.sh 7858176 4dda2dcbf5429ca9ad82487d5a30decbc6b9a87b 5498880 07dc66deb78f6e5d16a18e2d7a606559b849134d
fi

if ! applypatch -c EMMC:/dev/block/platform/msm_sdcc.1/by-name/recovery:7858176:4dda2dcbf5429ca9ad82487d5a30decbc6b9a87b; then
  applypatch -b /system/etc/recovery-resource.dat EMMC:/dev/block/platform/msm_sdcc.1/by-name/boot:5498880:07dc66deb78f6e5d16a18e2d7a606559b849134d EMMC:/dev/block/platform/msm_sdcc.1/by-name/recovery 4dda2dcbf5429ca9ad82487d5a30decbc6b9a87b 7858176 07dc66deb78f6e5d16a18e2d7a606559b849134d:/system/recovery-from-boot.p && log -t recovery "Installing new recovery image: succeeded" || log -t recovery "Installing new recovery image: failed"
else
  log -t recovery "Recovery image already installed"
fi
