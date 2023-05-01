
all: test

deps/traits:
	@mkdir -p deps/
	@git clone --branch v0.1.0 --depth 1 https://github.com/paulcadman/traits.git deps/traits

deps/test:
	@mkdir -p deps/
	@git clone --branch v0.2.0 --depth 1 https://github.com/paulcadman/test.git deps/test
	$(MAKE) -C deps/test deps

deps: deps/traits deps/test

build/Set: $(wildcard ./**/*.juvix) deps
	@mkdir -p build/
	juvix compile Test/Set.juvix -o build/Set

build/Map: $(wildcard ./**/*.juvix) deps
	@mkdir -p build/
	juvix compile Test/Map.juvix -o build/Map

build/AVL: $(shell find . -name '*.juvix') deps
	@mkdir -p build/
	juvix compile Data/Set/AVL.juvix -o build/AVL

.PHONY : test
test: build/Set build/Map build/AVL
	./build/Set
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

