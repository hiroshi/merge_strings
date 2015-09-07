.PHONY: all test clean

all: test clean

test:
	cp test/en.strings.src test/en.strings
	bin/merge_strings.rb test/ja.strings test/en.strings
	diff -u test/en.strings.expect test/en.strings

clean:
	rm test/en.strings
