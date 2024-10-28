rem == UEFI/GPT Partition Creation Script ==

rem == This script creates five partitions for a UEFI-based PC ==
rem    Windows RE tools, EFI System, MSR, Windows, and Recovery Image partitions ==

rem == Define Disk Variables ==
rem Adjust the variable %WinNTSetup_Disk% to the disk number where you want to install Windows
rem Disk letters for boot and install partitions are specified below as S: and W:

select disk %WinNTSetup_Disk%
clean
convert gpt

rem == 1. Create Windows RE tools partition (1000 MB) ==
create partition primary size=1000
set id="de94bba4-06d1-4d40-a16a-bfd50179d6ac"  rem GUID for Windows RE tools
gpt attributes=0x8000000000000001              rem Hidden and required partition attributes
format quick fs=ntfs label="Windows RE tools"  rem Format as NTFS and label it
assign letter="T"                              rem Assign letter T: to the partition

rem == 2. Create EFI System partition (100 MB) ==
create partition efi size=100                  rem EFI system partition for UEFI boot
format quick fs=fat32 label="System"           rem Format as FAT32 for EFI compatibility
assign letter="S"                              rem Assign letter S: to the partition

rem == 3. Create Microsoft Reserved (MSR) partition (128 MB) ==
create partition msr size=128                  rem MSR is a required partition for GPT systems

rem == 4. Create Windows partition ==
create partition primary                       rem Create the main partition for Windows
shrink minimum=15000                           rem Shrink to leave 15 GB space for recovery image
format quick fs=ntfs label="Windows"           rem Format as NTFS and label it Windows
assign letter="W"                              rem Assign letter W: to the partition

rem == 5. Create Recovery image partition ==
create partition primary                       rem Create the partition for the recovery image
set id="de94bba4-06d1-4d40-a16a-bfd50179d6ac"  rem GUID for the recovery image partition
gpt attributes=0x8000000000000001              rem Hidden and required partition attributes
format quick fs=ntfs label="Recovery image"    rem Format as NTFS and label it Recovery image
rem assign letter="R"                          rem Optional: Assign letter R: if needed

rem == List all volumes to verify partitions ==
list volume

rem == Exit DiskPart ==
exit