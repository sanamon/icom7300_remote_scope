CC=g++
CFLAGS=-g -c -Og -Wall -std=c++11
FL_CFLAGS=$(CFLAGS) `fltk-config --cxxflags --use-images`
LIBS=`fltk-config --ldflags` -lfltk -lfltk_images -lstdc++ -lXfixes -lXext -lpthread -ldl -lm -lX11

remscp: remscp.o serial.o ic7300.o flslider2.o progdefaults.o IC7300_waterfall.o
	$(CC) -o remscp remscp.o serial.o ic7300.o flslider2.o progdefaults.o IC7300_waterfall.o $(LIBS)

remscp.o: remscp.cxx

remscp.o: remscp.cxx IC7300_waterfall.h include/fldigi-config.h \
 include/digiscope.h include/complex.h include/flslider2.h serial.h \
 progdefaults.h
	$(CC) $(FL_CFLAGS) -MMD -MP -MF .deps/remscp.Tpo -c -Iinclude remscp.cxx

serial.o: serial.cxx serial.h ic7300.h
	$(CC) $(CFLAGS) -MMD -MP -MF .deps/serial.Tpo -c serial.cxx

ic7300.o: ic7300.cxx ic7300.h IC7300_waterfall.h include/fldigi-config.h \
 include/digiscope.h include/complex.h include/flslider2.h
	$(CC) $(CFLAGS) -MMD -MP -MF .deps/ic7300.Tpo -c -I. -I./include ic7300.cxx

flslider2.o: flslider2.cxx include/config.h include/pkg.h include/util.h include/flslider2.h
	g++ -DHAVE_CONFIG_H -I. -DBUILD_FLDIGI -DLOCALEDIR=\"/usr/local/share/locale\" -I./include -I./irrxml -I./libtiniconv -I./fileselector -I./xmlrpcpp -DPKGDATADIR=\"/usr/local/share/fldigi\" -pthread -I/usr/include/alsa -D_REENTRANT -I/usr/include/libpng16 -pipe -Wall -fexceptions -O2 -O0 -fno-inline-functions -ggdb3 -Wall --param=max-vartrack-size=0 -I./xmlrpcpp --param=max-vartrack-size=0 -UNDEBUG -MT flslider2.o -MMD -MP -MF .deps/flslider2.Tpo -c -o flslider2.o flslider2.cxx

progdefaults.o: progdefaults.cxx
	g++ -DHAVE_CONFIG_H -I. -DBUILD_FLDIGI -DLOCALEDIR=\"/usr/local/share/locale\" -I./include -I./irrxml -I./libtiniconv -I./fileselector -I./xmlrpcpp -DPKGDATADIR=\"/usr/local/share/fldigi\" -pthread -I/usr/include/alsa -D_REENTRANT -I/usr/include/libpng16 -pipe -Wall -fexceptions -O2 -O0 -fno-inline-functions -ggdb3 -Wall --param=max-vartrack-size=0 -I./xmlrpcpp --param=max-vartrack-size=0 -UNDEBUG -MT flslider2.o -MMD -MP -MF .deps/progdefaults.Tpo -c -o progdefaults.o progdefaults.cxx

IC7300_waterfall.o: IC7300_waterfall.cxx include/fl_lock.h include/stacktrace.h \
 include/debug.h include/util.h include/config.h include/pkg.h \
 include/config.h IC7300_waterfall.h include/digiscope.h \
 include/complex.h include/flslider2.h progdefaults.h
	g++ -DHAVE_CONFIG_H -I. -DBUILD_FLDIGI -DLOCALEDIR=\"/usr/local/share/locale\" -I./include -I./irrxml -I./libtiniconv -I./fileselector -I./xmlrpcpp -DPKGDATADIR=\"/usr/local/share/fldigi\" -pthread -I/usr/include/alsa -D_REENTRANT -I/usr/include/libpng16 -pipe -Wall -fexceptions -O2 -O0 -fno-inline-functions -ggdb3 -Wall --param=max-vartrack-size=0 -I./xmlrpcpp --param=max-vartrack-size=0 -UNDEBUG -MT IC7300_waterfall.o -MMD -MP -MF .deps/IC7300_waterfall.Tpo -c -o IC7300_waterfall.o IC7300_waterfall.cxx

.PHONY: all
all: remscp

.PHONY: clean
clean:
	rm -f *~ *.o remscp a.out
