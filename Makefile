TARGET = grab
VERSION := $(shell sed -n 's/^VER="\([^"]*\)"/\1/p' $(TARGET))
ARCHIVE = $(TARGET)-$(VERSION).zip

all: $(ARCHIVE) checksum

$(ARCHIVE): $(TARGET)
	zip $(ARCHIVE) $(TARGET)

checksum:
	sha256sum $(ARCHIVE) > $(ARCHIVE).sha256

clean:
	rm -f $(TARGET)-*.zip
	rm -f $(TARGET)-*.zip.sha256
