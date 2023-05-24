
all: test

deps/stdlib:
	@mkdir -p deps/
	@git clone https://github.com/anoma/juvix-stdlib.git deps/stdlib
	@git -C deps/stdlib checkout d40b0b90b2a3ddd05e145d7808305ef1b2c83f45

deps/test:
	@mkdir -p deps/
	@git clone --branch v0.5.1 --depth 1 https://github.com/anoma/juvix-test.git deps/test
	$(MAKE) -C deps/test deps

deps: deps/stdlib deps/test

build/UnbalancedSet: $(wildcard ./**/*.juvix) deps
	@mkdir -p build/
	juvix compile Test/UnbalancedSet.juvix -o build/UnbalancedSet

build/Map: $(wildcard ./**/*.juvix) deps
	@mkdir -p build/
	juvix compile Test/Map.juvix -o build/Map

build/AVL: $(shell find . -name '*.juvix') deps
	@mkdir -p build/
	juvix compile Test/AVL.juvix -o build/AVL

.PHONY : test
test: build/UnbalancedSet build/Map build/AVL
	./build/UnbalancedSet
	./build/Map
	./build/AVL

.PHONY: clean-build
clean-build:
	@rm -rf build/

.PHONY: clean-deps
clean-deps:
	@rm -rf deps/

.PHONY: clean
clean: clean-deps clean-build

