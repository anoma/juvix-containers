
all: test

build/UnbalancedSet: $(wildcard ./**/*.juvix)
	@mkdir -p build/
	juvix compile Test/UnbalancedSet.juvix -o build/UnbalancedSet

build/Map: $(wildcard ./**/*.juvix)
	@mkdir -p build/
	juvix compile Test/Map.juvix -o build/Map

build/AVL: $(shell find . -name '*.juvix')
	@mkdir -p build/
	juvix compile Test/AVL.juvix -o build/AVL

build/Queue: $(shell find . -name '*.juvix')
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

.PHONY: clean
clean: clean-build
	@juvix clean
