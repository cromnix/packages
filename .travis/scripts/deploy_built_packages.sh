#!/bin/bash
# deploy_built_packages.sh: to deploy built packages

REPODIR="/var/cache/manjaro-tools/pkg/unstable/x86_64/"
SFREPO="frs.sourceforge.net:/home/frs/project/mefiles/Manjaro/test/cromnix/packages/x86_64/"
SFUSER="aaditya1234"
REPO="packages"
REPO_REMOTE=$REPO-sf
REPODIR_REMOTE="$HOME/$REPO_REMOTE"

# for testing
echo "${HOME}/.ssh/id_rsa"

if [ ! -f "${HOME}/.ssh/id_rsa" ]; then
	# cant deploy without key
	echo "deployment key not found"
	exit 1
fi

# enable the key
eval "$(ssh-agent -s)"
ssh-add "$HOME/.ssh/id_rsa"

if [ "$(ls -1 ${REPODIR} | wc -l)" -gt 0 ]; then
	# we may have something to deploy
	mkdir -p "$REPODIR_REMOTE"
	echo "Fetching remote repo from sourceforge and saving to $REPODIR_REMOTE"
	rsync -auvLPH --delete-after "${SFUSER}"@"${SFREPO}" "$REPODIR_REMOTE" || exit 1
	# deploy the built packages
	cp -vf $REPODIR/*.pkg.tar.xz "${REPODIR_REMOTE}/" || flag=1  # repo state unchanged, nothing to do
	if [[ $flag -eq 1 ]]; then
		echo "Nothing to do"
		exit 0
	fi
	cd "$REPODIR_REMOTE" || exit 1
	# remove old versions
	echo "Trimming $REPODIR_REMOTE of old packages..."
	paccache -rv -k1 -c .
	# add packages to pacman db
	nice -n 20 repo-add "$REPO.db.tar.gz" ./*pkg.tar.xz
	rm -f "$REPO.db"
	cp -f "$REPO.db.tar.gz" "$REPO.db"
	echo "Uploading to $SFREPO"
	rsync -auvPH --delete-after ${REPODIR_REMOTE}/* "${SFUSER}"@"${SFREPO}"
fi

exit $?
