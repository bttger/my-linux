# Full disk encryption

```bash
$ cryptsetup benchmark
# Tests are approximate using memory only (no storage IO).
PBKDF2-sha1      2205207 iterations per second for 256-bit key
PBKDF2-sha256    4088015 iterations per second for 256-bit key
PBKDF2-sha512    1685813 iterations per second for 256-bit key
PBKDF2-ripemd160  860899 iterations per second for 256-bit key
PBKDF2-whirlpool  678250 iterations per second for 256-bit key
argon2i       5 iterations, 1048576 memory, 4 parallel threads (CPUs) for 256-bit key (requested 2000 ms time)
argon2id      5 iterations, 1048576 memory, 4 parallel threads (CPUs) for 256-bit key (requested 2000 ms time)
#     Algorithm |       Key |      Encryption |      Decryption
        aes-cbc        128b      1105.1 MiB/s      3125.5 MiB/s
    serpent-cbc        128b       108.4 MiB/s       680.3 MiB/s
    twofish-cbc        128b       221.3 MiB/s       400.1 MiB/s
        aes-cbc        256b       870.5 MiB/s      2725.3 MiB/s
    serpent-cbc        256b       112.3 MiB/s       680.5 MiB/s
    twofish-cbc        256b       228.7 MiB/s       399.8 MiB/s
        aes-xts        256b      2734.6 MiB/s      2732.8 MiB/s
    serpent-xts        256b       588.8 MiB/s       590.1 MiB/s
    twofish-xts        256b       367.3 MiB/s       368.7 MiB/s
        aes-xts        512b      2334.9 MiB/s      2329.1 MiB/s
    serpent-xts        512b       600.0 MiB/s       588.5 MiB/s
    twofish-xts        512b       368.8 MiB/s       368.2 MiB/s

---

$ (parted) print all                                                        
Model: SAMSUNG MZVLW256HEHP-000L2 (nvme)
Disk /dev/nvme0n1: 256GB
Sector size (logical/physical): 512B/512B
Partition Table: gpt
Disk Flags: 

Number  Start   End    Size    File system  Name  Flags
 1      2097kB  317MB  315MB   fat32              boot, esp
 2      317MB   234GB  233GB                root
 3      234GB   256GB  22.3GB

```

Links:

- https://wiki.archlinux.org/title/Securely_wipe_disk
- https://wiki.archlinux.org/title/Solid_state_drive/Memory_cell_clearing
- https://wiki.archlinux.org/title/Dm-crypt/Encrypting_an_entire_system
- https://wiki.archlinux.org/title/GRUB#Encrypted_/boot
- 
