FROM xxy1991/openwrt:imagebuilder-19.07.3

RUN sed -i 's/^[^#].*SQUASHFS/# &/' .config && \
    sed -i '/^#.*VMDK/c\CONFIG_VMDK_IMAGES=y' .config && \
    sed -i 's/\(CONFIG_GRUB_TIMEOUT=\).*/\1"3"/' .config
