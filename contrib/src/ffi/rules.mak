# FFI
FFI_VERSION := 3.0.13
FFI_URL := ftp://sourceware.org/pub/libffi/libffi-$(FFI_VERSION).tar.gz

ifdef HAVE_DARWIN_OS
PKGS += ffi
endif
ifeq ($(call need_pkg,"libffi"),)
PKGS_FOUND += ffi
endif

$(TARBALLS)/libffi-$(FFI_VERSION).tar.gz:
	$(call download,$(FFI_URL))

.sum-ffi: libffi-$(FFI_VERSION).tar.gz

ffi: libffi-$(FFI_VERSION).tar.gz .sum-ffi
	$(UNPACK)
	$(MOVE)

.ffi: ffi
	$(RECONF)
	cd $< && $(HOSTVARS) ./configure $(HOSTCONF)
	cd $< && $(MAKE) install
	touch $@
