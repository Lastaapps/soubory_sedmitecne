#!/usr/bin/env bash

sourceCode="${1}"

make "${1}"

make_result="$?"

if [ "$make_result" -eq 0 ]; then
	./"$@"
	echo "Result code: $?"
else
	echo "Make result code: $make_result"
fi

