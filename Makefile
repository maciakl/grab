TARGET = grab
ARCHIVE = grab.tar.gz

all: $(ARCHIVE)

$(ARCHIVE): $(TARGET)
	tar -czf $(ARCHIVE) $(TARGET)

clean:
	rm -f $(ARCHIVE)
