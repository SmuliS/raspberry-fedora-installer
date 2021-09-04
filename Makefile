FEDORA_VERSION = 33
FEDORA_RELEASE = 1.2

FEDORA_FILENAME = Fedora-Minimal-armhfp-$(FEDORA_VERSION)-$(FEDORA_RELEASE)-sda.raw.xz
FEDORA_MINIMAL = https://download.fedoraproject.org/pub/fedora/linux/releases/$(FEDORA_VERSION)/Spins/armhfp/images/$(FEDORA_FILENAME)

IMAGE = /tmp/$(FEDORA_FILENAME)

define DEVICE_HELP
Target device not defined

Define target as following: make install-fedora DEVICE=< device_id >

How to find device:
1. $ lsblk
2. find your device name e.g. sdb
3. /dev/sdb <- That is your device
endef

ifndef DEVICE
$(error $(DEVICE_HELP))
endif

PHONY: install-fedora
install-fedora: $(IMAGE)
	sudo fedora-arm-image-installer -y \
		--image=$< \
		--target=rpi3 \
		--media=$(DEVICE) \
		--resizefs \
		--addkey=~.ssh/id_rsa.pub \
		--norootpass

$(IMAGE):
	wget -O $@ $(FEDORA_MINIMAL)

