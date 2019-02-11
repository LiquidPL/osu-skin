VERSION = v0.0
PACKAGE_DIR = "Liquid $(VERSION)"
PACKAGE = "Liquid $(VERSION).osk"

TARGETS := $(patsubst src/%.svg, %.png, $(wildcard src/*.svg))
TARGETS2X := $(patsubst src/%.svg, %@2x.png, $(wildcard src/*.svg))

EMPTY = cursortrail.png


all: $(TARGETS) $(TARGETS2X) $(EMPTY) skin.ini

$(EMPTY):
	cp src/empty.png $@

skin.ini:
	cp src/skin.ini skin.ini

package:
	mkdir -p $(PACKAGE_DIR)
	cp $(TARGETS) $(TARGETS2X) $(EMPTY) $(PACKAGE_DIR)
	zip -r $(PACKAGE) $(PACKAGE_DIR)

clean:
	rm -rf $(TARGETS) $(TARGETS2X) $(EMPTY) $(PACKAGE_DIR) $(PACKAGE)

%.png: src/%.svg
	inkscape -z -e $@ -d 48 $^ 2> /dev/null

%@2x.png: src/%.svg
	inkscape -z -e $@ $^ 2> /dev/null
