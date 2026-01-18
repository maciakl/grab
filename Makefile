TARGET = grab
VERSION := $(shell sed -n 's/^VER="\([^"]*\)"/\1/p' $(TARGET))
ARCHIVE = $(TARGET)-$(VERSION).zip

all: $(ARCHIVE) checksum

$(ARCHIVE): $(TARGET)
	zip $(ARCHIVE) $(TARGET)

checksum:
	sha256sum $(ARCHIVE) > $(ARCHIVE).sha256

release: $(ARCHIVE) checksum
	git tag -a "v$(VERSION)" -m "Release version $(VERSION)"
	git push origin "v$(VERSION)"
	gh release create "v$(VERSION)" $(ARCHIVE) $(ARCHIVE).sha256 --title "v$(VERSION)" --generate-notes

clean:
	rm -f $(TARGET)-*.zip
	rm -f $(TARGET)-*.zip.sha256
