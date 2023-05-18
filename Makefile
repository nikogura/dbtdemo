GOMASON := $(shell which gomason)

# ensure `gomason` is installed
.PHONY: check-gomason
check-gomason:
	@if [ -z "${GOMASON}" ]; then echo "gomason not installed. You can fix this by running: go install github.com/nikogura/gomason@latest"; exit $1; fi

# Build the demo via 'go build'
dbtdemo: check-gomason
	go build

# build the demo via 'gomason'
gomason-build: check-gomason
	gomason build -vsl

gomason-publish: check-gomason
