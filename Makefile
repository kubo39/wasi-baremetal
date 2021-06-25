.PHONY: all

all: build

build:
	ldc2 -mtriple=wasm32-unknown-wasi \
		-betterC \
		-fvisibility=hidden \
		-defaultlib= \
		-of=app.wasm \
		app.d

run: build
	wasmtime app.wasm

clean:
	$(RM) *.o *.wasm

.DELETE_ON_ERROR:
