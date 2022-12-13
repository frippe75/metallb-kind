#!/bin/bash

for script in $(ls [0-9]*.sh)
do
	source $script
done
