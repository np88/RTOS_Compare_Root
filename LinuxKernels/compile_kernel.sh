# Parameters for directories: 
#					-k: Kernel directory 
#					-u: U-boot directory
#					-d: Device tree (including path)
#					-U: Create new BOOT.BIN file

# needed files for getting the processor booting from the SD card:

# u-boot.elf : u-boot elf file used to create the BOOT.BIN image (optional)
# fsbl.elf : FSBL elf image used to create BOOT.BIN image (optional)
# BOOT.BIN : Binary image containing the FSBL and u-boot images produced by bootgen

# uImage : Linux kernel image for u-boot, loaded into memory by u-boot

# devicetree.dtb : Device tree binary blob used by Linux, loaded into memory by u-boot

# uramdisk.image.gz : u-boot ramdisk image used by Linux, loaded into memory by u-boot

# export path for compiler and mkimage tool

kernel_directory="linux-xlnx";
uboot_directory="u-boot-xlnx";
device_tree="/arch/arm/boot/dts/zynq-zc702.dts"
uboot_bin_directory="Own/U-Boot_Files"

# export variables for building process 
export CROSS_COMPILE=arm-xilinx-linux-gnueabi-
export PATH=/home/race/LinuxKernels/u-boot-xlnx/tools/:$PATH
export PATH=/opt/CodeSourcery/Sourcery_CodeBench_Lite_for_Xilinx_GNU_Linux/bin/:$PATH

while getopts "k:u:d:U" OPT 
do
    case "$OPT" in
        k)	kernel_directory="$OPTARG";;
        u)	uboot_directory="$OPTARG";;
				d)  device_tree="$OPTARG";;
				U)	# Configure u-boot
						cd $uboot_directory
						make ARCH=arm zynq_zc70x_config
						# Building u-boot, can be found right at the root folder of /u-boot-xlnx 
						make ARCH=arm
						# Bootgen needs the elf-file to have an elf extension
						cp u-boot u-boot.elf
						# An fsbl.elf file for the bootimage can be created using SDK
						# The bootimage can be created using SDK as well or by simply creating a text file with the extension .bif with this content:
						# the_ROM_image:
						#{
						#	[bootloader]/root/workspace1/fsbl/Debug/fsbl.elf
						#	/home/race/LinuxKernels/u-boot-xlnx/u-boot.elf
						#}

						# Create BOOT.BIN file using bootgen
						rm ../$uboot_bin_directory/BOOT.BIN
						/opt/Xilinx/14.4/SDK/SDK/bin/lin/bootgen -image ../$uboot_bin_directory/bootimage.bif -o i ../$uboot_bin_directory/BOOT.BIN

						cd ../
						;;						
    esac
done

echo "uboot directory:" $uboot_directory
echo "kernel directory:" $kernel_directory
echo "device tree:" $device_tree

cd $kernel_directory
# Configure the kernel for the ZC702 or ZC770 hardware
make ARCH=arm xilinx_zynq_defconfig
# Create image, can be found at linux-xlnx/arch/arm/boot
make ARCH=arm uImage

# Device trees: Predefined device trees can be found in linux-xlnx/arch/arm/boot/dts
# Compile device tree
./scripts/dtc/dtc -I dts -O dtb -o devicetree.dtb ../$device_tree

# Generate 

# A root system can be build by using BusyBox. Here, an image from the prebuild system is used.

# Copy all files to output folder
cp ../$uboot_bin_directory/BOOT.BIN ../Disk/BOOT.BIN
cp ../$kernel_directory/arch/arm/boot/uImage ../Disk/uImage
cp ../$kernel_directory"/devicetree.dtb" ../Disk/devicetree.dtb
cp ../zc702/uramdisk.image.gz ../Disk/uramdisk.image.gz

