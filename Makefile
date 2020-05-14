CRYSTAL ?= crystal
SHARDS  ?= shards
AMEBA   ?= ameba

.PHONY: lint test

lint:
	@$(AMEBA) src

test:
	@$(CRYSTAL) spec
