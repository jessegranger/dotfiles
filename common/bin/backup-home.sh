#!/usr/bin/env bash

OUTDIR=$1
if test -z "$OUTDIR"; then
	echo Usage: $0 output-dir
	exit 1
fi
DATE=`date +%F-%H-%M`
FILE=$OUTDIR/backup-$DATE.tgz

cd $HOME && tar czvpf $FILE \
	./* \
	./.ssh \
	./.electrum \
	./.gnupg \
	./.lastpass \
	./.unnethackrc \
	./.zcash \
	./.zcash-params


