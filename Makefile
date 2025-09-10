TARGET = grab
VERSION := $(shell sed -n 's/^VER="\([^"]*\)"/\1/p' $(TARGET))
ARCHIVE = $(TARGET)-$(VERSION).zip

all: $(ARCHIVE)

$(ARCHIVE): $(TARGET)
	zip $(ARCHIVE) $(TARGET)

clean:
	rm -f $(TARGET)-*.zip
