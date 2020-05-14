CRYSTAL ?= crystal
SHARDS  ?= shards
AMEBA   ?= ameba

.PHONY: docs lint test

docs:
	@$(CRYSTAL) docs

lint:
	@$(AMEBA) src

test:
	@$(CRYSTAL) spec
