#!/bin/bash
# deploy_built_packages_in_chroot.sh: to deploy packages built in the chroot

CHROOT_DIR_NAME="manjaro-chroot"
CHROOT_DIR_LOC="${HOME}/manjaro-chroot"
CHROOT_BUILD_DIR_NAME="build"
CHROOT_BUILD_DIR_LOC="${CHROOT_DIR_LOC}/${CHROOT_BUILD_DIR_NAME}"

if [ ! -f "${HOME}/.ssh/id_rsa" ]; then
	# cant deploy without key
	echo "deployment key not found"
	exit 1
fi

# check what branch it is; we only deploy for certain branches
if [ "${TRAVIS_PULL_REQUEST_BRANCH}" != "" ]; then
	# in case of pull request we check originating branch
	CURRENT_BRANCH=${TRAVIS_PULL_REQUEST_BRANCH}
else
	CURRENT_BRANCH=${TRAVIS_BRANCH}
fi

ALLOWED_BRANCHES=(master deploy)
ALLOW_DEPLOY=1
for branch in "${ALLOWED_BRANCHES[@]}"; do
	if [ "$CURRENT_BRANCH" = $branch ]; then
		# check if check above is robust enough
		ALLOW_DEPLOY=0
		break
	fi
done

if [ "$ALLOW_DEPLOY" -eq 1 ]; then
	echo "not allowed to deploy for $CURRENT_BRANCH"
	exit 1
fi

# setup the key needed for deployment
sudo mkdir -p -m 700 "${CHROOT_DIR_LOC}/root/.ssh"
sudo cp -v "$HOME/.ssh/id_rsa" "${CHROOT_DIR_LOC}/root/.ssh/"
sudo chmod 600 "${CHROOT_DIR_LOC}/root/.ssh/id_rsa"
echo "StrictHostKeyChecking no" | sudo tee "${CHROOT_DIR_LOC}/root/.ssh/config"

# get repo name
REPO_NAME=$(echo $TRAVIS_REPO_SLUG | cut -f 2 -d /)

# chroot!
DEST=${CHROOT_DIR_LOC}
sudo mount -t proc proc $DEST/proc/
sudo mount -t sysfs sys $DEST/sys/
sudo mount -o bind /dev $DEST/dev/
sudo mount -o bind /run $DEST/run/
sudo cp /etc/resolv.conf $DEST/etc/resolv.conf

sudo chroot "${CHROOT_DIR_LOC}" /usr/bin/env HOME=/root USER=root /bin/bash -c "cd /build/$REPO_NAME && .travis/scripts/deploy_built_packages.sh"
EXIT_STATUS=$?

exit $EXIT_STATUS
