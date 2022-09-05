#!/vendor/bin/sh
if ! applypatch --check EMMC:/dev/block/by-name/recovery$(getprop ro.boot.slot_suffix):67633152:3e139dc565977cf7ba731eed4cfb47938727cabb; then
  applypatch \
          --patch /vendor/recovery-from-boot.p \
          --source EMMC:/dev/block/by-name/boot$(getprop ro.boot.slot_suffix):57671680:f1c8c5a466d0de8dd38ceb762e46d59fc865f194 \
          --target EMMC:/dev/block/by-name/recovery$(getprop ro.boot.slot_suffix):67633152:3e139dc565977cf7ba731eed4cfb47938727cabb && \
      (log -t install_recovery "Installing new recovery image: succeeded" && setprop vendor.ota.recovery.status 200) || \
      (log -t install_recovery "Installing new recovery image: failed" && setprop vendor.ota.recovery.status 454)
else
  log -t install_recovery "Recovery image already installed" && setprop vendor.ota.recovery.status 200
fi

