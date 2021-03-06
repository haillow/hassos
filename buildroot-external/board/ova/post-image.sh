#!/bin/bash
set -e

SCRIPT_DIR=${BR2_EXTERNAL_HASSOS_PATH}/scripts
BOARD_DIR=${2}
BOOT_DATA=${BINARIES_DIR}/boot

. ${SCRIPT_DIR}/hdd-image.sh
. ${SCRIPT_DIR}/name.sh
. ${SCRIPT_DIR}/ota.sh
. ${BR2_EXTERNAL_HASSOS_PATH}/info
. ${BOARD_DIR}/info

# Init boot data
rm -rf ${BOOT_DATA}
mkdir -p ${BOOT_DATA}/EFI/BOOT
mkdir -p ${BOOT_DATA}/EFI/barebox

cp ${BINARIES_DIR}/barebox.bin ${BOOT_DATA}/EFI/BOOT/BOOTx64.EFI
cp ${BR2_EXTERNAL_HASSOS_PATH}/misc/barebox-state-efi.dtb ${BOOT_DATA}/EFI/barebox/state.dtb

echo "console=tty1" > ${BOOT_DATA}/cmdline.txt

# Create other layers
prepare_disk_image

# Create disk images
create_disk_image 6
convert_disk_image_vmdk
create_ota_update
