#!/bin/bash
project=cromnix
brazil=(
	'ufpr'
	'razaoinfo'
)
bulgaria=(
	'netix'
)
canada=(
	'iweb'
)
czech=(
	'10Gbps.io'
)
france=(
	'freefr'
)
germany=(
	'netcologne'
)
india=(
	'excellmedia'
)
japan=(
	'jaist'
)
kenya=(
	'liquidtelecom'
)
taiwan=(
	'nchc'
	'ncu'
)
uk=(
	'kent'
	'vorboss'
)
us=(
	'ayera'
	'cfhcable'
	'cytranet'
	'gigenet'
	'managedway'
	'phoenixnap'
	'pilotfiber'
	'superb-dca2'
	'superb-sea2'
	'svwh'
	'versaweb'
)
host="sourceforge.net"
target_dir='repos/$repo/$arch'

printmirrors() {
	printf "\n## ${1}\n"
	declare -a mirrors=("${!2}")
	for mirror in ${mirrors[@]}; do
		printf "# Server = https://${mirror}.dl.${host}/project/${project}/${target_dir}\n"
	done
}
echo "##
## Cromnix repository mirrorlist
## Generated on $(date +%Y-%m-%d)
##"

printmirrors "Brazil" brazil[@]
printmirrors "Bulgaria" bulgaria[@]
printmirrors "Canada" canada[@]
printmirrors "Czech Replubic" czech[@]
printmirrors "France" france[@]
printmirrors "Germany" germany[@]
printmirrors "India" india[@]
printmirrors "Japan" japan[@]
printmirrors "Kenya" kenya[@]
printmirrors "Taiwan" taiwan[@]
printmirrors "United Kingdom" uk[@]
printmirrors "United States" us[@]

printf "\n## Misc\n"
printf "# Server = https://downloads.${host}/project/${project}/${target_dir}\n"
