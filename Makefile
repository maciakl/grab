TARGET = grab
ARCHIVE = grab.zip

all: $(ARCHIVE)

$(ARCHIVE): $(TARGET)
	zip $(ARCHIVE) $(TARGET)

clean:
	rm -f $(ARCHIVE)
