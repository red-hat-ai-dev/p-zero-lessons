PORT ?= 8888
DOCS_DIR := $(shell pwd)
SITE_DIR := $(DOCS_DIR)/www
PLAYBOOK := antora-playbook.yml

.PHONY: install build serve clean

install:
	cd $(DOCS_DIR) && npm install

build: install
	rm -rf $(SITE_DIR)
	cd $(DOCS_DIR) && npx antora --fetch $(PLAYBOOK) --stacktrace
	touch $(SITE_DIR)/.nojekyll

serve: build
	@echo "Serving whole site at http://localhost:$(PORT)"
	python3 -m http.server $(PORT) --directory $(SITE_DIR)

clean:
	rm -rf $(SITE_DIR)
