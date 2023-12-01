all: test

build/Main: $(wildcard ./**/*.juvix)
	@mkdir -p build/
	juvix compile test/Main.juvix -o build/Main

.PHONY : test
test: build/Main
	./build/Main

.PHONY: clean-build
clean-build:
	@rm -rf build/
	@juvix clean
	@(cd test && exec juvix clean)

.PHONY: clean
clean: clean-build
	@juvix clean
