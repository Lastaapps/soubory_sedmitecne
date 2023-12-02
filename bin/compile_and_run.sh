#!/bin/sh

sourceCode="${1}"
output="${sourceCode}.out"

# g++ -std=c++14 -Wall -Wshadow --pedantic -Wno-long-long -O2 -Werror -g -fsanitize=address -o "${1}" "${1}"
# g++ -std=c++14 -Wall -Wshadow --pedantic -Wno-long-long -Werror -g -fsanitize=address -o "${1}" "${1}"
g++ -std=c++17 -Wall -Wshadow --pedantic -Wno-long-long -Werror -g -fsanitize=address -o "${output}" "${sourceCode}"

compile_result="$?"

if [ "$compile_result" -eq 0 ]; then
	input=("$@")
	unset input[0] # skip .c or .cpp file name
	./"${output}" "${input[@]}"

	echo "Result code: $?"
else
	echo "Compile result code: $compile_result"
fi
