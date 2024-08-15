FROM ghcr.io/lesscodex/pkg/openwrt:imagebuilder-23.05.4

# RUN sed -i 's/^[^#].*SQUASHFS/# &/' .config && \
#     sed -i '/^#.*VMDK/c\CONFIG_VMDK_IMAGES=y' .config && \
#     sed -i 's/\(CONFIG_GRUB_TIMEOUT=\).*/\1"3"/' .config

RUN sed -i 's/\(CONFIG_GRUB_TIMEOUT=\).*/\1"3"/' .config
