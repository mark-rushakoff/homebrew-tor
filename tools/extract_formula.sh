#!/bin/sh

set -e

if [ "$#" != 1 ]; then
  echo "Extracts the history of tor.rb into a new git repo" >&2
  echo "Usage: $0 TARGET_DIR" >&2
  exit 1
fi

TARGET_DIR=$1

# As of this writing, most recent commit on the Tor formula
COMMIT=a401237f040e0b2069991da9d4d0311688a0d487

git clone https://github.com/Homebrew/homebrew.git "$TARGET_DIR"
cd "$TARGET_DIR"

git checkout -b formula $COMMIT
git filter-branch --prune-empty --index-filter 'git rm --cached -q -r . && git reset -q $GIT_COMMIT -- Library/Formula/tor.rb LICENSE.txt'

cat <<EOF
You can merge in these changes by something like:

  git remote add formula "$TARGET_DIR"
  git fetch formula
  git merge formula/formula
EOF
