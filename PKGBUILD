# Maintainer: Chris Cromer <chris@cromer.cl>

pkgname=patch
pkgver=2.7.1
pkgrel=1
pkgdesc='A utility to apply patch files to original sources'
arch=('x86_64')
url='https://www.gnu.org/software/patch/patch.html'
license=('GPL')
groups=('cromnix-base')
depends=('glibc')
makedepends=('ed')
optdepends=('ed: for "patch -e" functionality')
source=("ftp://ftp.gnu.org/gnu/$pkgname/${pkgname}-${pkgver}.tar.xz"{,.sig})
md5sums=('e9ae5393426d3ad783a300a338c09b72'
		 'SKIP')

prepare() {
	cd "${srcdir}/${pkgname}-${pkgver}"
}

build() {
	cd "${srcdir}/${pkgname}-${pkgver}"
	./configure --prefix=/usr
	make
}

check() {
	cd "${srcdir}/${pkgname}-${pkgver}"
	make check
}

package() {
	cd "${srcdir}/${pkgname}-${pkgver}"
	make DESTDIR="${pkgdir}" install
}
