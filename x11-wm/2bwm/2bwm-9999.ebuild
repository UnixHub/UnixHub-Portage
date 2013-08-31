# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=0

inherit git-2 savedconfig flag-o-matic

DESCRIPTION="A fast floating WM written over the XCB library and derived from mcwm."

HOMEPAGE="https://github.com/venam/2bwm"
EGIT_REPO_URI="git://github.com/venam/2bwm.git"
SRC_URI=""

LICENSE="ICS"
SLOT="0"
KEYWORDS="~x86 ~amd64"

RDEPEND="x11-libs/xcb-util
	x11-libs/xcb-util-wm
	x11-libs/xcb-util-keysyms"
DEPEND="${RDEPEND}"

src_compile() {
	epatch "${FILESDIR}/${PV}-Makefile.diff"
	LDFLAGS=" -L/usr/lib"
	restore_config config.h
	emake || die "Compile failed"
}

src_install() {
	mkdir -p ${D}/usr/bin
	mkdir -p ${D}/usr/share/man/man1
	emake "PREFIX=${D}/usr" install || die "Install failed"
	save_config config.h
}

pkg_postinst() {
	einfo "This ebuild has support for user defined configs"
	einfo "Please read this ebuild for more details and re-emerge as needed"
	einfo "if you want to add or remove functionality for ${PN}"
}
