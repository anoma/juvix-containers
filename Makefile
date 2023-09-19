all: test

deps/stdlib:
	@mkdir -p deps/
	@git clone https://github.com/anoma/juvix-stdlib.git deps/stdlib
	@git -C deps/stdlib checkout 4facf14d9b2d06b81ce1be1882aa9050f768cb45

deps/test:
	@mkdir -p deps/
	@git clone --branch static-dependencies --depth 1 https://github.com/anoma/juvix-test.git deps/test
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

build/Queue: $(shell find . -name '*.juvix') deps
	@mkdir -p build/
	juvix compile Test/Queue.juvix -o build/Queue

.PHONY : test
test: build/UnbalancedSet \
		build/Map \
		build/AVL \
		build/Queue
	./build/UnbalancedSet
	./build/Map
	./build/AVL
	./build/Queue

.PHONY: clean-build
clean-build:
	@rm -rf build/

.PHONY: clean-deps
clean-deps:
	@rm -rf/

.PHONY: clean
clean: clean-deps clean-build
