LDC = ldc2

TARGET = app.wasm
SRC = app.d

.PHONY: all clean

all: $(TARGET)

$(TARGET): $(SRC)
	$(LDC) -mtriple=wasm32-unknown-wasi \
		-betterC \
		-fvisibility=hidden \
		-defaultlib= \
		-of=$@ \
		$^

run: $(TARGET)
	wasmtime $^

clean:
	$(RM) *.o $(TARGET)

.DELETE_ON_ERROR:
