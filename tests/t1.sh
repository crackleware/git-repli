#!/bin/sh

git_log_graph () { pwd; git log --all --graph --decorate | cat; }

send_apply_updates () {
	pushd $DIR/r1

	GIT_REPLI_TAG=TAG1 GIT_REPLI_SENDMAIL=../fake-send-mail GIT_REPLI_PLAIN=1 \
		git-repli-send-mail u2@domain.local

	pushd $DIR/r2

	GIT_REPLI_TAG=TAG1 ../fake-get-mail | GIT_REPLI_PLAIN=1 git-repli-parse-mail

	git_log_graph

	popd
	popd
}

rm -rf r1 r2

set -e

export DIR=$(pwd)
export PATH=$(cd ..; pwd):$PATH

mkdir $DIR/r1
cd $DIR/r1
git init
git config user.name u1
git config user.email u1@domain.local

mkdir $DIR/r2
cd $DIR/r2
git init
git config user.name u2
git config user.email u2@domain.local

cd $DIR/r1

date >> d1
git add d1
git commit -a -m ...

sleep 2

date >> d1
git commit -a -m ...

git_log_graph

send_apply_updates

sleep 2

date >> d1
git commit -a -m ...

git branch exp
git checkout exp

sleep 2

date >> d1
date >> d2
git add d2
git commit -a -m ...

sleep 2

date >> d1
date >> d2
git commit -a -m ...

git_log_graph

send_apply_updates

git checkout master

sleep 2

date >> d1
date >> d3
git add d3
git commit -a -m ...

sleep 2

date >> d3
git commit -a -m ...

git checkout exp

sleep 2

date >> d2
git commit -a -m ...

git_log_graph

send_apply_updates

echo test finished.
