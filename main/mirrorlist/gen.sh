#!/bin/bash
project=cromnix
mirrors=('heanet' 'jaist' 'netcologne' 'iweb' 'kent') host="sourceforge.net"
target_dir='repos/$repo/$arch'

echo "https://downloads.sourceforge.net/project/${project}/${target_dir}"
for mirror in ${mirrors[@]};do
        echo "https://${mirror}.dl.${host}/project/${project}/${target_dir}"
done
