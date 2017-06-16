#!/bin/bash

echo "firmware\n" > gen.txt

for dir in $(find ./ -maxdepth 1 -type d -not -name '.' -and -not -name '..'  -and -not -name '.git'); do
    dir=${dir#./}
    echo "        'linux-firmware-${dir}'" >> gen.txt
done


for dir in $(find ./ -maxdepth 1 -type d -not -name '.' -and -not -name '..'  -and -not -name '.git'); do
    dir=${dir#./}
    echo "package_linux-firmware-${dir}() {" >> gen.txt
    echo "    groups=('linux-firmware')" >> gen.txt
    echo "    cd \"\${pkgbase}\"" >> gen.txt
    echo "    make DESTDIR=\${pkgdir} FIRMWAREDIR=/usr/lib/firmware install" >> gen.txt
    echo "    _remove_firmware \$pkgname" >> gen.txt
    if [ "$dir" == "intel" ]; then
        echo "    cd \${pkgdir}/usr/lib/firmware" >> gen.txt
        echo "    rm intelliport2.bin" >> gen.txt
    fi
    if [ "$dir" == "bnx2" ]; then
        echo "    cd \${pkgdir}/usr/lib/firmware" >> gen.txt
        echo "    rm bnx2x*" >> gen.txt
    fi
    echo "}" >> gen.txt
    echo "" >> gen.txt
done
