.PHONY : test

TEMP_FILE := $(shell mktemp)
test:
	@juvix compile Data/Set.juvix -o $(TEMP_FILE)
	$(TEMP_FILE)
	@juvix compile Data/Map.juvix -o $(TEMP_FILE)
	$(TEMP_FILE)
	rm $(TEMP_FILE)
