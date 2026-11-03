#!/usr/bin/env bash

BUNDLES=$(git submodule status | awk '{print $2}')
P=$(pwd | sed -e "s@~@$HOME@")

for bundle in $BUNDLES; do
	cd "$P/$bundle"; git checkout master; git pull
	cd "$P"
done
