# $OpenBSD: Makefile,v 1.72 2017/07/26 22:45:16 sthen Exp $

COMMENT =	Berkeley DB, revision ${REV}

REV=		4.8
VERSION=	${REV}.30
DISTNAME=	db-${VERSION}.NC
PKGNAME=	db-${VERSION}
CATEGORIES =	coin
PKGSPEC=	db->=4.8,<5

# License: BSD + SleepyCat's additions.
# Must purchase license to redistribute if not distributing the source.
PERMIT_PACKAGE=	Yes

#MASTER_SITES=	http://download.oracle.com/berkeley-db/

DEST_SUBDIR=	${REV}
WANTLIB=	c m ${COMPILER_LIBCXX}

SEPARATE_BUILD = yes
CONFIGURE_SCRIPT = dist/configure
CONFIGURE_STYLE = gnu

CONFIGURE_ARGS = --enable-cxx \
		 --disable-shared \
		 --with-pic \
		 --prefix=/usr/local \
		 --includedir=$$\{prefix}/include/db${DEST_SUBDIR} \
		 --libdir=$$\{prefix}/lib/db${DEST_SUBDIR} \
		 --docdir=$$\{prefix}/share/doc/db${DEST_SUBDIR}

post-install:
	echo "PREFIX=${PREFIX}"
	for F in archive checkpoint deadlock dump hotbackup load printlog recover sql stat upgrade verify; do mv ${PREFIX}/bin/db_$$F ${PREFIX}/bin/db${DEST_SUBDIR}_$$F; done
	mkdir -p ${PREFIX}/share/doc
	mv ${PREFIX}/docs ${PREFIX}/share/doc/db${DEST_SUBDIR}

.include <bsd.port.mk>
