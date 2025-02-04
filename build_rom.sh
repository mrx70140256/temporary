# sync rom
repo init -u https://github.com/crdroidandroid/android.git -b 12.1 --git-lfs
git clone https://github.com/mrx7014/gtaxl-manifests.git -b crdroid-12.1 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch lineage_gtaxllte-userdebug
export TZ=Africa/Egypt #put before last build command.
brunch gtaxllte

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
