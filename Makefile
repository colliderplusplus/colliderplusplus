VPATH =src:src/tny_osc:include:include/tny_osc
UNAME := $(shell uname)

ifeq ($(UNAME), Darwin)
  libtype = dynamiclib
  libsuffix = dylib
endif

ifeq ($(UNAME), Linux)
  libtype = shared
  libsuffix = so
endif

INSTALL_LIB_DIR = /usr/local/lib/
INSTALL_INCLUDE_DIR = /usr/local/include/

libcollider: tnyosc-dispatch.o SCServer.o Buffer.o Bus.o Node.o Sound.o 
	gcc -$(libtype) -o libcollider.$(libsuffix) src/tnyosc-dispatch.o src/SCServer.o src/Buffer.o src/Bus.o src/Node.o src/Sound.o -lstdc++ 
	mkdir -p build
	mv libcollider.$(libsuffix) build

tnyosc-dispatch.o : tnyosc-dispatch.cc tnyosc-dispatch.hpp tnyosc.hpp
	gcc -c -fPIC -o src/tnyosc-dispatch.o src/tnyosc-dispatch.cc -Iinclude/tny_osc/

SCServer.o : SCServer.cpp SCServer.hpp tnyosc-dispatch.o
	gcc -c -fPIC -o src/SCServer.o src/SCServer.cpp -Iinclude/ #-DPRINT_DEBUG

Buffer.o : Buffer.cpp Buffer.hpp
	gcc -c -fPIC -o src/Buffer.o  src/Buffer.cpp -Iinclude/ #-DPRINT_DEBUG
Bus.o : Bus.cpp Bus.hpp
	gcc -c -fPIC -o src/Bus.o  src/Bus.cpp -Iinclude/
Node.o : Node.cpp Node.hpp
	gcc -c -fPIC -o src/Node.o  src/Node.cpp -Iinclude/
Sound.o : Sound.cpp Sound.hpp
	gcc -c -fPIC -o src/Sound.o  src/Sound.cpp -Iinclude/

clean: 
	rm src/*.o
	rm -rf $(wildcard build)

install:
	cp build/libcollider.$(libsuffix) $(INSTALL_LIB_DIR)
	mkdir -p $(INSTALL_INCLUDE_DIR)collider
	cp -r include/* $(INSTALL_INCLUDE_DIR)collider
	chmod 0755 $(INSTALL_LIB_DIR)libcollider.$(libsuffix)
	chmod 0755 $(INSTALL_INCLUDE_DIR)collider
	chmod 0755 $(INSTALL_INCLUDE_DIR)collider/*
	chmod 0755 $(INSTALL_INCLUDE_DIR)collider/tny_osc
	chmod 0755 $(INSTALL_INCLUDE_DIR)collider/tny_osc/*
	
uninstall:
	rm $(INSTALL_LIB_DIR)libcollider.$(libsuffix)
	rm -r $(INSTALL_INCLUDE_DIR)collider
